import {Column, Entity, OneToMany, PrimaryGeneratedColumn} from "typeorm"
import {JobModel} from "./JobModel"

@Entity()
export class UserModel {
    @PrimaryGeneratedColumn()
    id: number
    @Column()
    name: string

    @OneToMany(() => JobModel, job => job.issuer)
    jobs: Promise<JobModel[]>
}