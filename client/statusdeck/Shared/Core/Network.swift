//
//  Network.swift
//  Statusdeck
//
//  Created by Simon Ammer on 13.05.21.
//

import Apollo
import Foundation

class Network {
    private let url = URL(string: "http://localhost:4000/graphql")!

    static let shared = Network()

    private(set) lazy var apollo = ApolloClient(url: url)
}
