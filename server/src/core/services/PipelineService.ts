import {Repository} from "typeorm";
import {Service} from "typedi";
import {PipelineModel} from "../../dal/entity/PipelineModel";
import {InjectRepository} from "typeorm-typedi-extensions";
import {BaseService} from "./base/BaseService";

@Service()
export class PipelineService extends BaseService<PipelineModel> {
    constructor(@InjectRepository(PipelineModel) pipelineRepository: Repository<PipelineModel>) {
        super(pipelineRepository);
    }
}
