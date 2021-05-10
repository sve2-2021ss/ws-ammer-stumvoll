import DataLoader, {BatchLoadFn} from "dataloader";
import {StageService} from "../../core/services/StageService";
import {Stage} from "../types/Stage";
import {Container} from "typedi";
import {splitIntoChunksById} from "./base/matchOrdering";

const stagesByJobIdBatchFn: BatchLoadFn<number, Stage[]> = async (keys) => {
    const stages = await Container.get(StageService).getAllForEachJob([...keys])
    return splitIntoChunksById(stages, keys, "jobId")
}

export const stagesByJobIdLoader = () => new DataLoader(stagesByJobIdBatchFn)