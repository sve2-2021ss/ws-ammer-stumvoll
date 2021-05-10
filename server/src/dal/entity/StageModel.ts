import {State} from "./State"
import {Column, Entity, JoinColumn, ManyToOne, PrimaryGeneratedColumn} from "typeorm"
import {JobModel} from "./JobModel"

@Entity()
export class StageModel {
    @PrimaryGeneratedColumn()
    id: number

    @Column()
    order: number

    @Column()
    name: string

    @Column({
        type: "enum",
        enum: State,
    })
    state: State

    @Column({nullable: true})
    startedAt?: number

    @Column({nullable: true})
    finishedAt?: number

    @ManyToOne(() => JobModel, job => job.stages)
    @JoinColumn({name: "jobId"})
    job: Promise<JobModel>

    @Column()
    jobId: number
}