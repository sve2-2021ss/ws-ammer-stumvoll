import {Column, Entity, JoinColumn, ManyToOne, OneToMany, PrimaryGeneratedColumn} from "typeorm"
import {PipelineModel} from "./PipelineModel"
import {StageModel} from "./StageModel"
import {ChangeModel} from "./ChangeModel"
import {State} from "./State"
import {UserModel} from "./UserModel"

@Entity()
export class JobModel {
    @PrimaryGeneratedColumn()
    id: number

    @Column()
    name: string

    @Column({nullable: true})
    started?: number

    @Column({nullable: true})
    finished?: number

    @Column({
        type: "enum",
        enum: State,
    })
    state: State

    @Column({type: "text"})
    logs: string

    @ManyToOne(() => PipelineModel, pipeline => pipeline.jobs)
    @JoinColumn({name: "pipelineId"})
    pipeline: Promise<PipelineModel>

    @Column()
    pipelineId: number

    @OneToMany(() => ChangeModel, change => change.job)
    changes: Promise<ChangeModel[]>

    @OneToMany(() => StageModel, stage => stage.job)
    stages: Promise<StageModel[]>

    @ManyToOne(() => UserModel, user => user.jobs)
    @JoinColumn({name: "issuerId"})
    issuer: Promise<UserModel>

    @Column()
    issuerId: number
}