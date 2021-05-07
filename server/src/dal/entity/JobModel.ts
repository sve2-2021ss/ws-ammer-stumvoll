import {Column, Entity, ManyToOne, OneToMany, PrimaryGeneratedColumn} from "typeorm";
import {PipelineModel} from "./PipelineModel";
import {StageModel} from "./StageModel";
import {ChangeModel} from "./ChangeModel";

@Entity()
export class JobModel {
    @PrimaryGeneratedColumn()
    id: number
    @Column()
    name: string
    @Column()
    started?: number
    @Column()
    finished?: number
    @Column()
    logs: string
    @ManyToOne(() => PipelineModel, pipeline => pipeline.jobs)
    pipeline: Promise<PipelineModel>
    @ManyToOne(() => ChangeModel, change => change.job)
    changes: Promise<ChangeModel[]>
    @OneToMany(() => StageModel, stage => stage.job)
    stages: Promise<StageModel[]>
}