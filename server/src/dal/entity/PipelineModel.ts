import {Column, Entity, OneToMany, PrimaryGeneratedColumn} from "typeorm";
import {JobModel} from "./JobModel";

@Entity()
export class PipelineModel {
    @PrimaryGeneratedColumn()
    id: number;
    @Column()
    name: string
    @OneToMany(() => JobModel, job => job.pipeline)
    jobs: Promise<JobModel[]>
}