//
//  SettingsViewModel.swift
//  Statusdeck
//
//  Created by Simon Ammer on 13.05.21.
//

import Combine
import Foundation

public class SettingsViewModel: ObservableObject {
    @Published var versionString: String

    init() {
        versionString = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "n/a"
    }
}
