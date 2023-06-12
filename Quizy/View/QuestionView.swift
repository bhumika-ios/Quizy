//
//  QuestionView.swift
//  Quizy
//
//  Created by Bhumika Patel on 10/06/23.
//

import SwiftUI
import LottieSwiftUI

extension Views {
    struct QuestionView: View {
        @ObservedObject var viewModel: ViewModel
        @State var isAnimating: Bool = false
        @State var currentQuestion: Int = 0 {
            didSet {
                viewModel.update(question: Manager.API.shared.questions[currentQuestion])
                isAnimating = false
            }
        }
        var body: some View {
            ZStack {
                Color("BlueLight1")
               .edgesIgnoringSafeArea(.all)
                if viewModel.answers.count == 0 {
                    renderBody(answerType: .multiple, isAnimating: $isAnimating)
                        .padding(.horizontal, DesignSystem.Padding.macroPadding)
                        .redacted(reason: .placeholder)
                } else {
                    renderBody(
                        answerType: viewModel.answerType,
                        isAnimating: $isAnimating
                    )
                    .padding(.horizontal, DesignSystem.Padding.macroPadding)
                }
            }
        }

        @ViewBuilder private func renderBody(
            answerType: Manager.API.AnswerTypes,
            isAnimating: Binding<Bool>
        ) -> some View {
            VStack(spacing: DesignSystem.Padding.microPadding) {
                viewModel.image
                Text(viewModel.title)
                    .bold()
                    .padding(.bottom, DesignSystem.Padding.macroPadding)
                Text(viewModel.question)
                    .bold()
                    .padding(.bottom, DesignSystem.Padding.macroPadding)
                switch answerType {
                case .multiple:
                    ForEach(0 ..< 4) { index in
                        MultipleChoiceButton(
                            isAnimating: $isAnimating,
                            isCorrect: viewModel.checkIfRightAnswer(
                                questionNumber: currentQuestion,
                                index: index
                            ),
                            buttonText: viewModel.answers.count == 0 ? "" : viewModel.answers[index]
                        )
                    }
                case .boolean:
                    HStack {
                        BooleanButton(isAnimating: $isAnimating,
                            isCorrect: viewModel.checkBooleanQuestion(
                                answer: "True",
                                questionNumber: currentQuestion
                            ),
                            buttonText: viewModel.answers.count == 0 ? "" : "True"
                        )
                        Spacer()
                        BooleanButton(isAnimating: $isAnimating,
                            isCorrect: viewModel.checkBooleanQuestion(
                              answer: "False",
                              questionNumber: currentQuestion
                            ),
                            buttonText: viewModel.answers.count == 0 ? "" : "False"
                        )
                    }
                case .any:
                    fatalError("Don't insert .any")
                }
                if currentQuestion < Manager.API.shared.questions.count - 1 && self.isAnimating {
                    SwiftUI.Button(action: { currentQuestion += 1 }) {
                        VStack{
                            Text("Next Question")
                                .foregroundColor(.white)
                        }
                        
                        .background{
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color("Blue"))
                                .frame(width: 165, height: 45)
                            
                        }
                        .padding()
                    }
                } else if currentQuestion >= Manager.API.shared.questions.count - 1 && self.isAnimating {
                    NavigationLink(destination: ConclusionView(viewModel: .init()).navigationBarHidden(true)
//                        .onAppear {
//                            Manager.SFX.playSound(sound: .finished)
//                        }
                    ) {
                        VStack{
                            Text("Finish quiz")
                                .foregroundColor(.white)
                        }
                        .background{
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.red)
                                .frame(width: 165, height: 45)
                        }
                        .padding()
                    }
                }
            }.foregroundColor(.black)
                .padding(DesignSystem.Padding.macroPadding)
        }
    }
}

extension Views.QuestionView {
    class ViewModel: ObservableObject {
        let manager = Manager.API()
        @Published var category: Manager.API.QuestionCategory = .all
        @Published var title: String = ""
        @Published var image: Image = .init("Logo")
        @Published var question: String = ""
        @Published var answerType: Manager.API.AnswerTypes = .multiple
        @Published var answers: [String] = []

        public func checkIfRightAnswer(questionNumber: Int, index: Int) -> Bool {
            if answers.count == 0 {
                return false
            }
            return answers[index] == Manager.API.shared.questions[questionNumber].correct_answer
        }

        public func checkBooleanQuestion(answer: String, questionNumber: Int) -> Bool {
            return answer == Manager.API.shared.questions[questionNumber].correct_answer ? true : false
        }

        public func update(question: Question) {
            self.title = question.category.categoryName
            self.image = Image(question.category.categoryName)
            self.question = question.question
            self.answerType = question.type
            self.answers.removeAll()
            self.answers.append(question.correct_answer)
            question.incorrect_answers.forEach {
                self.answers.append($0)
            }
            self.category = question.category
            self.answers.shuffle()
        }
    }
}

#if DEBUG
struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        Views.QuestionView(viewModel: .init())
    }
}
#endif
