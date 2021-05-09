export interface Job {
    id: number,
    name: string
    started?: number
    finished?: number
    logs: string,
    issuerId: number,
}
