import {Column, Entity, ManyToOne, PrimaryColumn} from "typeorm";
import {UserModel} from "./UserModel";
import {JobModel} from "./JobModel";

@Entity()
export class ChangeModel {
    @PrimaryColumn()
    commitId: string
    @Column()
    message: string
    @ManyToOne(() => UserModel)
    changer: Promise<UserModel>
    @ManyToOne(() => JobModel, job => job.changes)
    job: Promise<JobModel>
}