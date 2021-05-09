import {Column, Entity, JoinColumn, ManyToOne, PrimaryGeneratedColumn} from "typeorm";
import {UserModel} from "./UserModel";
import {JobModel} from "./JobModel";

@Entity()
export class ChangeModel {
    @PrimaryGeneratedColumn()
    id: number

    @Column()
    commitId: string

    @Column()
    message: string

    @ManyToOne(() => UserModel)
    @JoinColumn({name: "changerId"})
    changer: Promise<UserModel>

    @Column()
    changerId: number

    @ManyToOne(() => JobModel, job => job.changes)
    @JoinColumn({name: "jobId"})
    job: Promise<JobModel>

    @Column()
    jobId: number
}