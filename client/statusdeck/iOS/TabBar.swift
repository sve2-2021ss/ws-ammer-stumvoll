//
//  TabBar.swift
//  statusdeck (iOS)
//
//  Created by Simon Ammer on 07.05.21.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            NavigationView {
                Pipeline(viewModel: PipelineViewModel())
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Image(systemName: "line.horizontal.3.decrease")
                Text("Pipelines")
            }
            Settings(viewModel: SettingsViewModel())
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
    }
}
