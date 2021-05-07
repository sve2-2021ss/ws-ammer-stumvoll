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
            ForEach(Category.allCases) { category in
                ItemsListView(viewModel: ItemsViewModel(category: category))
                    .tabItem {
                        Image(systemName: category.icon)
                        Text(category.name)
                    }
            }
        }
    }
}
