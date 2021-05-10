import {BaseService} from "./base/BaseService"
import {ChangeModel} from "../../dal/entity/ChangeModel"
import {InjectRepository} from "typeorm-typedi-extensions"
import {In, Repository} from "typeorm"
import {Service} from "typedi"

@Service()
export class ChangeService extends BaseService<ChangeModel> {
    constructor(@InjectRepository(ChangeModel) changeRepository: Repository<ChangeModel>) {
        super(changeRepository)
    }

    public getAllForEachJob(jobIds: number[]): Promise<ChangeModel[]> {
        return this.repository.find({where: {jobId: In(jobIds)}})
    }
}