import {BaseService} from "./base/BaseService"
import {InjectRepository} from "typeorm-typedi-extensions"
import {Repository} from "typeorm"
import {Service} from "typedi"
import {UserModel} from "../../dal/entity/UserModel"

@Service()
export class UserService extends BaseService<UserModel> {
    constructor(@InjectRepository(UserModel) stageRepository: Repository<UserModel>) {
        super(stageRepository)
    }
}