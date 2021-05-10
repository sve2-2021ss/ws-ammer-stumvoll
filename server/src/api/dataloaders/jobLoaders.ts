import DataLoader, {BatchLoadFn} from "dataloader"
import {Job} from "../types/Job"
import {JobService} from "../../core/services/JobService"
import {Container} from "typedi"
import {splitIntoChunksById} from "./base/matchOrdering"

const jobsByPipelineIdBatchFn: BatchLoadFn<number, Job[]> = async (keys) => {
    const jobs = await Container.get(JobService).getAllForEachPipeline([...keys])
    return splitIntoChunksById(jobs, keys, "pipelineId")
}

export const jobsByPipelineIdLoader = () => new DataLoader(jobsByPipelineIdBatchFn)