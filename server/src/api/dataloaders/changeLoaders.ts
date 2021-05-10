import {ChangeService} from "../../core/services/ChangeService";
import DataLoader, {BatchLoadFn} from "dataloader";
import {Change} from "../types/Change";
import {Container} from "typedi";
import {splitIntoChunksById} from "./base/matchOrdering";

const changesByJobIdBatchFn: BatchLoadFn<number, Change[]> = async (keys) => {
    const changes = await Container.get(ChangeService).getAllForEachJob([...keys])
    return splitIntoChunksById(changes, keys, "jobId")
}

export const changesByJobIdLoader = () => new DataLoader(changesByJobIdBatchFn)