//
//  JobsViewModel.swift
//  Statusdeck
//
//  Created by Simon Ammer on 14.05.21.
//

import Apollo
import ApolloCombine
import Combine
import Foundation

class JobsViewModel: ObservableObject, Identifiable {
    private var subscriptions: Set<AnyCancellable> = []
    private let client = Network.shared.apollo
    private let pipelineId: GraphQLID

    @Published var loading: Bool = true
    @Published var error: Error?
    @Published var jobs: [JobsQuery.Data.Pipeline.Job] = []

    init(id: GraphQLID) {
        pipelineId = id
    }

    func reload() {
        loading = true
        client.fetchPublisher(query: JobsQuery(pipelineId: pipelineId), cachePolicy: .returnCacheDataAndFetch)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                if case let .failure(error) = completion {
                    self.error = error
                }
                self.loading = false
            }, receiveValue: { [weak self] graphQLResult in
                guard let self = self else { return }
                self.jobs = graphQLResult.data?.pipeline?.jobs ?? []
            })
            .store(in: &subscriptions)
    }
}
