import DataLoader, {BatchLoadFn} from "dataloader";
import {Container} from "typedi";
import {UserService} from "../../core/services/UserService";
import {User} from "../types/User";
import {matchOrderingById} from "./base/matchOrdering";

const userByIdBatchFn: BatchLoadFn<number, User> = async (keys) => {
    const users = await Container.get(UserService).getAllIn([...keys])
    return matchOrderingById(users, keys)
}

export const userByIdLoader = () => new DataLoader(userByIdBatchFn)