# Statusdeck Server

*tbd: describe the different ways to define the schema*

## Schema Definition

A typescript schema can generally be generated in three ways:

- defining the schema manually as text
- defining the schema using code
- using annotations and classes to define the schema

Since all three of those were considered for this exercise, the advantages and drawbacks will be described below. The
evaluation is only based on the Node.js ecosystem.

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