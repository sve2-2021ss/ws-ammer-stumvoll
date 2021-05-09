import {In, Repository} from "typeorm";
import {JobModel} from "../../dal/entity/JobModel";
import {Service} from "typedi";
import {BaseService} from "./base/BaseService";
import {InjectRepository} from "typeorm-typedi-extensions";

@Service()
export class JobService extends BaseService<JobModel> {
    constructor(@InjectRepository(JobModel) jobRepository: Repository<JobModel>) {
        super(jobRepository);
    }

    public getAllForEachPipeline(pipelineIds: number[]): Promise<JobModel[]> {
        return this.repository.find({where: {pipelineId: In(pipelineIds)}})
    }
}
