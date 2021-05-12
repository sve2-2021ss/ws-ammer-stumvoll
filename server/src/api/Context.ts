import {jobsByIdLoader, jobsByPipelineIdLoader} from "./dataloaders/jobLoaders"
import {changesByJobIdLoader} from "./dataloaders/changeLoaders"
import {stagesByJobIdLoader} from "./dataloaders/stageLoaders"
import {userByIdLoader} from "./dataloaders/userLoaders"
import {pipelineByIdLoader} from "./dataloaders/pipelineLoaders";

export const createContext = () => ({
    loaders: {
        pipelinesById: pipelineByIdLoader(),
        jobsByPipelineId: jobsByPipelineIdLoader(),
        jobsById: jobsByIdLoader(),
        changesByJobId: changesByJobIdLoader(),
        stagesByJobId: stagesByJobIdLoader(),
        usersById: userByIdLoader()
    }
})

export type Context = ReturnType<typeof createContext>