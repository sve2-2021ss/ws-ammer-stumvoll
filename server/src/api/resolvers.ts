import {IResolvers} from "apollo-server"
import {Context} from "./Context"
import {Pipeline} from "./types/Pipeline"
import {Container} from "typedi"
import {PipelineService} from "../core/services/PipelineService"
import {Job} from "./types/Job"
import {Change} from "./types/Change"

// noinspection JSUnusedGlobalSymbols
export const resolvers: IResolvers<any, Context> = {
    Pipeline: {
        jobs: (pipeline: Pipeline, _, {loaders}): Promise<Job[]> => loaders.jobsByPipelineId.load(pipeline.id),
    },
    Job: {
        changes: (job: Job, _, {loaders}) => loaders.changesByJobId.load(job.id),
        stages: (job: Job, _, {loaders}) => loaders.stagesByJobId.load(job.id),
        issuer: (job: Job, _, {loaders}) => loaders.usersById.load(job.issuerId)
    },
    JobById: {
        pipeline: (job: Job, _, {loaders}) => loaders.pipelinesById.load(job.pipelineId)
    },
    Change: {
        changer: (change: Change, _, {loaders}) => loaders.usersById.load(change.changerId)
    },
    Query: {
        pipeline: (_, {id}) => Container.get(PipelineService).getById(Number(id)),
        pipelines: () => Container.get(PipelineService).getAll(),
        job: (pipeline: Pipeline, {id}, {loaders}) => loaders.jobsById.load(Number(id))
    },
}