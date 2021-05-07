//
//  statusdeckApp.swift
//  Shared
//
//  Created by Simon Ammer on 07.05.21.
//

import SwiftUI

@main
struct StatusdeckApp: App {
    var body: some Scene {
        WindowGroup {
            #if os(macOS)
                NavigationView {
                    Sidebar()
                    ItemsListView(viewModel: ItemsViewModel(category: .pipelines))
                }
            #else
                NavigationView {
                    TabBar()
                        .navigationTitle("Statusdeck")
                }.navigationViewStyle(StackNavigationViewStyle())
            #endif
        }
    }
}
