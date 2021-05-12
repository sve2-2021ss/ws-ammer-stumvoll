import DataLoader, {BatchLoadFn} from "dataloader"
import {Job} from "../types/Job"
import {JobService} from "../../core/services/JobService"
import {Container} from "typedi"
import {matchOrderingById, splitIntoChunksById} from "./base/matchOrdering"

const jobsByPipelineIdBatchFn: BatchLoadFn<number, Job[]> = async (keys) => {
    const jobs = await Container.get(JobService).getAllForEachPipeline([...keys])
    return splitIntoChunksById(jobs, keys, "pipelineId")
}

const jobsByIdBatchFn: BatchLoadFn<number, Job> = async (keys) => {
    const jobs = await Container.get(JobService).getAllIn([...keys])
    return matchOrderingById(jobs, keys)
}

export const jobsByPipelineIdLoader = () => new DataLoader(jobsByPipelineIdBatchFn)

export const jobsByIdLoader = () => new DataLoader(jobsByIdBatchFn)