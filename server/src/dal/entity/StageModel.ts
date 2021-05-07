import {State} from "./State";
import {Column, Entity, OneToMany, PrimaryGeneratedColumn} from "typeorm";
import {JobModel} from "./JobModel";

@Entity()
export class StageModel {
    @PrimaryGeneratedColumn()
    id: number
    @Column()
    name: string
    @Column({
        type: "enum",
        enum: State,
    })
    state: State
    @Column()
    startedAt?: number
    @Column()
    finishedAt?: number
    @OneToMany(() => JobModel, job => job.stages)
    job: Promise<JobModel>
}