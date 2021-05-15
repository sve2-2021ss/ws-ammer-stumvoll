//
//  Settings.swift
//  Statusdeck
//
//  Created by Simon Ammer on 13.05.21.
//

import SwiftUI

struct Settings: View {
    @ObservedObject var viewModel = SettingsViewModel()

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
