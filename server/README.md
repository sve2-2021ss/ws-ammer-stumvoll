# Statusdeck Server

*tbd: describe the different ways to define the schema*

## Implementation

The statusdeck server

## Data Loader

A common issue with GraphQL APIs is the n+1 query problem. This occurs for example when a user fetches a list of books
and for each book an additional query needs to be made to fetch the author as well. This is not ideal as more books are
fetched more additional queries need to be executed.

Luckily the GraphQL team implemented a utility called `data-loader`, which solves exactly this problem. It does so by
providing a mechanism to batch requests and execute them as one database query. For this to work, the database queries
need to be adapted as the data needs to be fetched using `IN` queries.

This functionality is provided by the class `DataLoader`. When a new `DataLoader` is created a batching function needs
to be provided. This function receives a key array (keys can be anything e.g. an id, or a name) which contains all the
keys that should be loaded and returns an array of the result type containing the results corresponding to the keys.
There are two constraints which must be fulfilled by this batching function:

* The output array must be the same length as the key array.
* The index of each element of the output array must match the index of the key array.

These two constraints are necessary as the connection between key and result is based on the index, this means if a key
has index `1` the result array needs to contain the result for this key also on index `1`.

To use a `DataLoader` it provides `load` function which receives the key and returns a promise of the return type.
The `DataLoader` also provides a caching mechanism which means the result of the load function is cached for a given key
to reduce redundant loads. In the snippet below is an example of how a batch function is implemented and how the data
loader is used.

```typescript
const jobsByIdBatchFn: BatchLoadFn<number, Job> = async (keys) => {
    const jobs = await Container.get(JobService).getAllIn(keys)
    const groupedById = groupBy(jobs, "id") //groups entities by the given key
    return keys.flatMap((id): (T | Error)[] => groupedById.get(id) ?? [new Error()])
}

const dataLoader = new DataLoader(jobsByIdBatchFn)

const result = await dataLoader.load(1)

const result2 = await dataLoader.load(1) //yields the cached result
```

As already mentioned does the `DataLoaders` also provide a caching mechanism. This means a `DataLoader` should only be
used in the scope of a single request. Otherwise, some users might get cached results which were loaded from other
users.

To solve this in the implementation of the statusdeck server the context capability of apollo was used. This makes it
possible to pass a context creation function to the server which creates a new context on each request. This context can
then be accessed in the resolver functions.

### Example

The following example demonstrates how this works in the statusdeck server. The following query fetches all pipelines,
for each pipeline all jobs and for all jobs the user who triggered it and all the changes with the user who changed it.

```graphql
{
    pipelines {
        name
        jobs {
            issuer {
                name
            }
            name
            changes {
                message
                changer {
                    id
                }
            }
        }
    }
}
```

The table below shows the amount of queries required for this request when no batching is used. Assuming the database
contains 30 pipelines with 20 jobs each, which again contain 10 changes each, the query from above would lead to a total
of **7631** separate queries executed.

| Queries | Name of the Query              | Result Size |
|---------|--------------------------------|-------------|
| 1       | Get all pipelines              | n           |
| n       | Get all jobs for each pipeline | m           |
| n*m     | Get issuer for each job        | l           |
| n*m     | Get all changes for each job   | k           |
| n\*m\*k | Get changer for each change    | j           |

Using a `DataLoader` for each entity means the amount of queries can be reduced to the just **4**.

* Get all pipelines
* Get all jobs where pipelineId in (..)
* Get all users where id in (..)
* Get all changes where jobId in (..)

It also doesn't matter if the amount of pipelines or jobs increases as it would just lead to more parameters in
each `in` query but not more queries executed.

## Schema Definition

A GraphQL schema can generally be generated in three ways:

- defining the schema manually as text
- defining the schema using code
- using annotations and classes to define the schema

Since all three of those were considered for this exercise, the advantages and drawbacks will be described below. The
evaluation is only based on the Node.js ecosystem.

In the end, manual schema definition was used for the statusdeck server, as was deemed as the most practical solution
with the best flexibility. It additionally does not require any dependencies.

### Manual Schema Definition

Defining the schema manually is the most basic approach. The complete schema is defined as a string or in a schema
file (see example below) and parsed using a library function (`gql` in apollo). The resolvers of the schema need to be
written manually as seen in the snippet below.

The advantage to this is that there aren't any additional dependencies to external libraries necessary. The major
drawback is that everything needs to be managed manually. For example if a field changes it needs to be updated in the
schema and then manually updated in the code. There are also no type information available in the code as the schema,
and the code aren't really connected.

```graphql
type User{
    name: String!
    bestFriend: User
    friends(first: Int!): [User!]!
}
```

```typescript
export const resolvers = {
    // other resolvers
    User: {
        friends: (user: User, {first}) => {

        }
    },
}
```

There are libraries like `graphql-codegen` available which use the schema to generate source code for types and
resolvers. This is useful since it provides proper typings for arguments and return types of resolvers. One drawback is,
that the library generates the types exactly as you define them in the schema. In the example above this would mean
a `User` type with the fields `name`, `bestFriend` and `friends` will be generated. However, this might not be how the
data is represented as a user might only contain `name` and `bestFriend` while `friends` are fetched in a separate
query. The library has a configuration option to replace these types with user defined ones, but this means they need to
be manually managed again.

### Schema as Code

The second way to define a GraphQL schema is by specifying the schema in code. This approach is supported natively by
the `graphql` library. For this a schema object with the desired fields and parameters needs to be constructed (example
in the snippet below). The resolvers are directly implemented in the object.

The biggest drawback to this is that these objects are very cumbersome to write, especially for non-nullable types as
they need to be wrapped with `new GraphQLNonNull()`. In addition to that the resolvers are not properly typed. The only
real advantage compared to manually defined schemas is that a changes only needs to be implemented in one place.

```typescript
const UserType = new GraphQLObjectType({
    name: 'User',
    fields: () => ({
        name: {type: new GraphQLNonNull(GraphQLString)},
        bestFriend: {type: UserType},
        friends: {
            args: {
                first: {type: GraphQLInt}
            },
            type: new GraphQLList(UserType),
            resolve: (user, {first}) => {
            }
        }
    })
})
```

### Schema using Annotations

The third and probably most convenient way to define GraphQL schemas is through annotations. This is not a native
feature of the Node.js GraphQL library but is instead provided by a library called `type-graphql`.

In this approach types and resolvers are defined by annotating classes and their fields and functions. A source code
example for this can be seen below. This approach solves the main pain points of the other two approaches namely the
disconnect between schema and source code, and the lack of proper type information.

Sadly this library comes with its own flaws. For example, it adds a lot of complexity by providing its own dependency
injection and middleware mechanism. The biggest one however is the difficulty it takes to integrate the `data-loader`
utility.

```typescript
@ObjectType()
class User {
    @Field()
    name: string;

    @Field(type => User, {nullable: true})
    bestFriend?: User;

    @Field(type => [User])
    friends: User[];
}

@Resolver(of => User)
class UserResolver {
    @FieldResolver()
    friends(@Root() user: User, @Arg("first") first: number): User[] {

    }
}
```