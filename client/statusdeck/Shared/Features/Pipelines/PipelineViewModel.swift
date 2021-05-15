//
//  PipelineViewModel.swift
//  Statusdeck
//
//  Created by Simon Ammer on 13.05.21.
//

import ApolloCombine
import Combine
import Foundation

public class PipelineViewModel: ObservableObject {
    private var subscriptions: Set<AnyCancellable> = []
    private let client = Network.shared.apollo

    @Published var loading: Bool = true
    @Published var error: Error?
    @Published var pipelines: [PipelinesQuery.Data.Pipeline] = []

    func reload() {
        loading = true
        client.fetchPublisher(query: PipelinesQuery(), cachePolicy: .returnCacheDataAndFetch)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                if case let .failure(error) = completion {
                    self.error = error
                }
                self.loading = false
            }, receiveValue: { [weak self] graphQLResult in
                guard let self = self else { return }
                self.pipelines = graphQLResult.data?.pipelines ?? []
            })
            .store(in: &subscriptions)
    }
}
