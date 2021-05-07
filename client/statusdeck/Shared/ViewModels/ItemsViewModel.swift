//
//  ItemsViewModel.swift
//  statusdeck
//
//  Created by Simon Ammer on 07.05.21.
//

import Combine
import Foundation

public class ItemsViewModel: ObservableObject {
    var subscriptions: Set<AnyCancellable> = []
    private let category: Category

    @Published var loading: Bool = true
    @Published var error: Error?
    @Published var items: [String] = []

    init(category: Category) {
        self.category = category
    }

    func reload() {
        loading = false
        items = ["test1", "test2", "test3"]
    }
}
