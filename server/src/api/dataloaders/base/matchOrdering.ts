const groupBy = <T, K extends keyof T>(array: T[], key: K): Map<T[K], T[]> =>
    array.reduce((map, item) => {
        const arr = map.get(item[key]) || []
        arr.push(item)
        map.set(item[key], arr)
        return map;
    }, new Map<T[K], T[]>())

export const splitIntoChunksById = <T, K extends keyof T>(entities: T[], ids: readonly (T[K])[], key: K): T[][] => {
    const groupedBy = groupBy(entities, key)
    return ids.map(id => groupedBy.get(id) ?? [])
}

export const matchOrderingById = <T extends { id: number }>(entities: T[], ids: readonly number[]): (T | Error)[] => {
    const groupedById = groupBy(entities, "id")
    return ids.flatMap((id): (T | Error)[] => groupedById.get(id) ?? [new Error()])
}