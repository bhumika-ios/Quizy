//
//  MultipleChoiceButton.swift
//  Quizy
//
//  Created by Bhumika Patel on 10/06/23.
//

import SwiftUI
import LottieSwiftUI

extension Views {
    struct MultipleChoiceButton: View {
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
                  //  Manager.SFX.playSound(sound: isCorrect ? .correct: .wrong)
                    Manager.AnswerTracker.shared.addResult(answerStatus: isCorrect)
                }
            ) {
                HStack {
                    Text(buttonText)
                    Spacer()
                    ZStack {
                        if isAnimating {
                            LottieView(name: isCorrect ? "correct": "wrong")
                                .lottieLoopMode(.playOnce)
                        }
                    }
                    .frame(width: Constants.animationFrame, height: Constants.animationFrame)
                }
                .padding()
            } .background(
                RoundedRectangle(cornerRadius: Constants.rectangleCornerRadius, style: .circular)
                    .fill(Color.white)
            )
//                .overlay(RoundedRectangle(cornerRadius: Constants.rectangleCornerRadius)
//                    .stroke(Color.black, lineWidth: Constants.strokeLineWidth)
//            )
                .padding(.bottom, DesignSystem.Padding.padding)
                .disabled(isAnimating)
        }
    }
}

extension Views.MultipleChoiceButton {
    struct Constants {
        static let animationFrame: CGFloat = 30
        static let rectangleCornerRadius: CGFloat = 13
        static let opacity: Double = 0.3
        static let strokeLineWidth: CGFloat = 1
    }
}
