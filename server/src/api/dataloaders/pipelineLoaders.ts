import DataLoader, {BatchLoadFn} from "dataloader";
import {Container} from "typedi";
import {matchOrderingById} from "./base/matchOrdering";
import {PipelineService} from "../../core/services/PipelineService";
import {Pipeline} from "../types/Pipeline";

const pipelineByIdBatchFn: BatchLoadFn<number, Pipeline> = async (keys) => {
    const stages = await Container.get(PipelineService).getAllIn([...keys])
    return matchOrderingById(stages, keys)
}

export const pipelineByIdLoader = () => new DataLoader(pipelineByIdBatchFn)