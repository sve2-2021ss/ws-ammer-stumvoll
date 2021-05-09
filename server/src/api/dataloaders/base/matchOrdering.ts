export const splitIntoChunksById = <T>(entities: T[], ids: readonly number[], idGetter: (entity: T) => number) =>
    entities.reduce((result: T[][], item: T): T[][] => {
        const i = ids.indexOf(idGetter(item))
        result[i].push(item)
        return result;
    }, ids.map(_ => []))

export const matchOrderingById = <T extends { id: number }>(entities: T[], ids: readonly number[]) =>
    entities.reduce((result: T[], item: T) => {
        const i = ids.indexOf(item.id)
        result[i] = item
        return result
    }, new Array(ids.length))