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
        VStack {
            #if os(iOS)
                LottieView(name: "debug", loopMode: .loop)
                    .frame(width: 250, height: 250)
            #endif
            HStack {
                Text("Version: ")
                Text(viewModel.versionString)
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
