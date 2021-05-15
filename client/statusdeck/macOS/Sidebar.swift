//
//  Sidebar.swift
//  statusdeck (macOS)
//
//  Created by Simon Ammer on 07.05.21.
//

import SwiftUI

struct Sidebar: View {
    var body: some View {
        List {
            NavigationLink(destination: Pipeline(viewModel: PipelineViewModel())) {
                Label("Pipeline", systemImage: "line.horizontal.3.decrease")
            }
            NavigationLink(destination: Settings(viewModel: SettingsViewModel())) {
                Label("Settings", systemImage: "gear")
            }
        }
        .listStyle(SidebarListStyle())
        .frame(minWidth: 150, idealWidth: 150, maxWidth: 200, maxHeight: .infinity)
        .padding(.top, 16)
    }
}
