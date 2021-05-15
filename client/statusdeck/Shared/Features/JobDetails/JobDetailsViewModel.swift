//
//  JobDetailsViewModel.swift
//  Statusdeck
//
//  Created by Simon Ammer on 15.05.21.
//

import Apollo
import ApolloCombine
import Combine
import Foundation

class JobDetailsViewModel: ObservableObject, Identifiable {
    private var subscriptions: Set<AnyCancellable> = []
    private let client = Network.shared.apollo
    private let jobId: GraphQLID

    @Published var loading: Bool = true
    @Published var error: Error?
    @Published var job: JobQuery.Data.Job?

    init(id: GraphQLID) {
        jobId = id
    }

    func reload() {
        loading = true
        client.fetchPublisher(query: JobQuery(jobId: jobId), cachePolicy: .returnCacheDataAndFetch)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                if case let .failure(error) = completion {
                    self.error = error
                }
                self.loading = false
            }, receiveValue: { [weak self] graphQLResult in
                guard let self = self else { return }
                self.job = graphQLResult.data?.job ?? nil
            })
            .store(in: &subscriptions)
    }
}
