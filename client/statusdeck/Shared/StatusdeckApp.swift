//
//  StatusdeckApp.swift
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
                    Pipeline(viewModel: PipelineViewModel())
                }
            #else
                TabBar()
            #endif
        }
    }
}
