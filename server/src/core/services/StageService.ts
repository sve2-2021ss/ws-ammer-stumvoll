import {BaseService} from "./base/BaseService";
import {StageModel} from "../../dal/entity/StageModel";
import {InjectRepository} from "typeorm-typedi-extensions";
import {In, Repository} from "typeorm";
import {Service} from "typedi";

@Service()
export class StageService extends BaseService<StageModel> {
    constructor(@InjectRepository(StageModel) stageRepository: Repository<StageModel>) {
        super(stageRepository);
    }

    public getAllForEachJob(jobIds: number[]): Promise<StageModel[]> {
        return this.repository.find({where: {jobId: In(jobIds)}})
    }
}