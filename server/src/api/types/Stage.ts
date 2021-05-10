import {State} from "../../dal/entity/State"

export interface Stage {
    id: number
    order: number
    name: string
    state: State,
    startedAt?: number
    finishedAt?: number
}