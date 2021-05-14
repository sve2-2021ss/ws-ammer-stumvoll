//
//  StatusIndicator.swift
//  Statusdeck
//
//  Created by Simon Ammer on 13.05.21.
//

import SwiftUI

struct StateIndicator: View {
    private let diameter: CGFloat = 15
    private let shadowRadius: CGFloat = 3
    private let shadowY: CGFloat = 5

    @SwiftUI.State var state = State.upcoming

    var body: some View {
        switch state {
        case .upcoming:
            Circle()
                .fill(Color.gray)
                .frame(width: diameter, height: diameter)
                .shadow(color: .gray.opacity(0.2), radius: shadowRadius, y: shadowY)
        case .running:
            Circle()
                .fill(Color.yellow)
                .frame(width: diameter, height: diameter)
                .shadow(color: .yellow.opacity(0.2), radius: shadowRadius, y: shadowY)
        case .finished:
            Circle()
                .fill(Color.green)
                .frame(width: diameter, height: diameter)
                .shadow(color: .green.opacity(0.2), radius: shadowRadius, y: shadowY)
        default:
            Circle()
                .fill(Color.black)
                .frame(width: diameter, height: diameter)
                .shadow(color: .black.opacity(0.2), radius: shadowRadius, y: shadowY)
        }
    }
}

struct StateIndicator_Previews: PreviewProvider {
    static var previews: some View {
        StateIndicator(state: .upcoming)
        StateIndicator(state: .running)
        StateIndicator(state: .finished)
    }
}
