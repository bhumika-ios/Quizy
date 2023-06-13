//
//  BooleanButton.swift
//  Quizy
//
//  Created by Bhumika Patel on 12/06/23.
//

import SwiftUI
import LottieSwiftUI

extension Views {
    struct BooleanButton: View {
        @Binding var isAnimating: Bool
        let isCorrect: Bool // True -> correct answer -- False -> wrong answer
        let buttonText: String
        init(
            isAnimating: Binding<Bool>,
            isCorrect: Bool,
            buttonText: String
        ) {
            self.isCorrect = isCorrect
            self.buttonText = buttonText
            self._isAnimating = isAnimating
        }
        var body: some View {
            SwiftUI.Button(
                action: {
                    isAnimating = true
                //    Manager.SFX.playSound(sound: isCorrect ? .correct: .wrong)
                    Manager.AnswerTracker.shared.addResult(answerStatus: isCorrect)
                }
            ) {
                ZStack {
                    Text(buttonText)
                        .foregroundColor(Color.black)
                        .font(.system(size: Constants.fontSize))
                    if isAnimating {
                        LottieView(name: isCorrect ? "correct": "wrong")
                            .lottieLoopMode(.playOnce)
                    }
                }
                .frame(width: Constants.animationFrame, height: Constants.animationFrame)
                .padding()
            }.background(
                RoundedRectangle(cornerRadius: Constants.rectangleCornerRadius, style: .circular)
                    .fill(buttonText == "True" ?
                          Color.green.opacity(Constants.opacity):
                          Color.red.opacity(Constants.opacity))
            )
            .overlay(
                RoundedRectangle(cornerRadius: Constants.rectangleCornerRadius, style: .circular)
                    .strokeBorder(Color.black, lineWidth: Constants.strokeLineWidth)
            )
            .disabled(isAnimating)
        }
    }
}

extension Views.BooleanButton {
    struct Constants {
        static let fontSize: CGFloat = 20
        static let animationFrame: CGFloat = 100
        static let rectangleCornerRadius: CGFloat = 13
        static let opacity: Double = 0.75
        static let strokeLineWidth: CGFloat = 3
    }
}
