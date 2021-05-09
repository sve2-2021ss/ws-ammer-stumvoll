import {jobsByPipelineIdLoader} from "./dataloaders/jobLoaders";
import {changesByJobIdLoader} from "./dataloaders/changeLoaders";
import {stagesByJobIdLoader} from "./dataloaders/stageLoaders";
import {userByIdLoader} from "./dataloaders/userLoaders";

export const createContext = () => ({
    loaders: {
        jobsByPipelineId: jobsByPipelineIdLoader(),
        changesByJobId: changesByJobIdLoader(),
        stagesByJobId: stagesByJobIdLoader(),
        usersById: userByIdLoader()
    }
})

export type Context = ReturnType<typeof createContext>