//
//  Category.swift
//  statusdeck
//
//  Created by Simon Ammer on 07.05.21.
//

import Foundation

enum Category: String, CaseIterable, Identifiable {
    var id: String {
        rawValue
    }

    case pipelines
    case settings

    var name: String {
        switch self {
        case .pipelines: return "Pipelines"
        case .settings: return "Settings"
        }
    }

    var icon: String {
        switch self {
        case .pipelines: return "line.horizontal.3.decrease"
        case .settings: return "gear"
        }
    }
}
