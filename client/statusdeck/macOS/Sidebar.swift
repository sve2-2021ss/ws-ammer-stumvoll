//
//  Sidebar.swift
//  statusdeck (macOS)
//
//  Created by Simon Ammer on 07.05.21.
//

import SwiftUI

struct Sidebar: View {
    var body: some View {
        List(Category.allCases) { category in
            NavigationLink(destination: ItemsListView(viewModel: ItemsViewModel(category: category))) {
                Label(category.name, systemImage: category.icon)
            }
        }
        .listStyle(SidebarListStyle())
        .frame(minWidth: 150, idealWidth: 150, maxWidth: 200, maxHeight: .infinity)
        .padding(.top, 16)
    }
}
