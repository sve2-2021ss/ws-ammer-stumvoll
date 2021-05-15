//
//  LottieView.swift
//  Statusdeck
//
//  Created by Simon Ammer on 14.05.21.
//

import Lottie
import SwiftUI

#if os(iOS)
    struct LottieView: UIViewRepresentable {
        var name: String
        var loopMode: LottieLoopMode = .playOnce

        var animationView = AnimationView()

        func makeUIView(context _: UIViewRepresentableContext<LottieView>) -> UIView {
            let view = UIView(frame: .zero)

            animationView.animation = Animation.named(name)
            animationView.contentMode = .scaleAspectFit
            animationView.loopMode = loopMode
            animationView.play()

            animationView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(animationView)

            NSLayoutConstraint.activate([
                animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
                animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
            ])

            return view
        }

        func updateUIView(_: UIView, context _: UIViewRepresentableContext<LottieView>) {}
    }
#endif
