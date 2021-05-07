import 'reflect-metadata';
import {readFileSync} from 'fs';
import {join} from 'path';
import {ApolloServer, gql, IResolvers} from 'apollo-server';
import {Pipeline} from "./api/types/Pipeline";
import {createConnection} from "typeorm";
import DataLoader, {BatchLoadFn} from 'dataloader';

startup().then()

async function startup() {
    const connection = await createConnection();
    const typeDefs = gql(readFileSync(join(__dirname, "./api/schema.gql"), "utf8").toString());


    const jobs = [
        {
            id: 1, name: "test1"
        },
        {
            id: 2, name: "test2"
        },
    ]

    const fakeDB: Pipeline[] = [
        {
            id: 1,
            name: "xD"
        },
        {
            id: 2,
            name: "xDD"
        }
    ];

    const x: BatchLoadFn<number, Pipeline> = async (keys) => {
        console.log("keys", keys)
        return Promise.resolve(fakeDB)
    }

    const pipelineLoader = new DataLoader(x)

    const resolvers: IResolvers = {
        Query: {
            async pipeline(_, {id}): Promise<Pipeline> {
                return await pipelineLoader.load(id);
            },
            pipelines(): Pipeline[] {
                return fakeDB;
            }
        },
        Pipeline: {
            jobs(pipeline: Pipeline): Promise<Pipeline> {
                return pipelineLoader.load(pipeline.id)

            }
        }
    }

    const server = new ApolloServer({typeDefs, resolvers});
    const {url} = await server.listen();
    console.log(`Server started @ ${url}`);
}
