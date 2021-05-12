import {createConnection} from "typeorm"
import {readFileSync} from "fs"
import {join} from 'path'

const readSqlFile = (filepath: string): string[] => {
    return readFileSync(join(__dirname, filepath))
        .toString()
        .replace(/\r?\n|\r/g, '')
        .split(';')
        .filter((query) => query?.length)
}

async function doInsert() {
    const sql = readSqlFile("/../database/insert.sql")

    const connection = await createConnection()
    for (const index in sql) {
        console.log(sql[index])
        await connection.query(sql[index])
    }
}

doInsert().then(() => {
    console.log("insert finished")
    process.exit(0)
})

