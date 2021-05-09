import {In, Repository} from "typeorm";

export class BaseService<Entity extends { id: number }> {

    constructor(protected repository: Repository<Entity>) {
    }

    public getById(id: number): Promise<Entity | undefined> {
        return this.repository.findOne({where: {id}});
    }

    public getAll(): Promise<Entity[]> {
        return this.repository.find()
    }
    
    public getAllIn(ids: number[]): Promise<Entity[]> {
        return this.repository.find({where: {id: In(ids)}})
    }
}