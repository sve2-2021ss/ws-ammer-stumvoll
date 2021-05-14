//
//  MultiplatformListModifier.swift
//  Statusdeck
//
//  Created by Simon Ammer on 13.05.21.
//

import SwiftUI

struct MultiplatformListModifier: ViewModifier {
    func body(content: Content) -> some View {
        #if os(iOS)
            return content.listStyle(GroupedListStyle())
        #endif
        return content
    }
}
