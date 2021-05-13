import 'reflect-metadata'
import {readFileSync} from 'fs'
import {join} from 'path'
import {ApolloServer, gql} from 'apollo-server'
import {createConnection, useContainer} from "typeorm"
import {Container as ormContainer} from "typeorm-typedi-extensions"
import {resolvers} from "./api/resolvers"
import {createContext} from "./api/Context"

startup().then()

async function startup() {
    useContainer(ormContainer)
    await createConnection()
    const typeDefs = gql(readFileSync(join(__dirname, "./api/schema.gql"), "utf8").toString())

    const server = new ApolloServer({typeDefs, resolvers, context: createContext})
    const {url} = await server.listen()
    console.log(`Server started @ ${url}`)
}
