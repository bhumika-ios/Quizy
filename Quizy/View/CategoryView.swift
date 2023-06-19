//
//  CategoryView.swift
//  Quizy
//
//  Created by Bhumika Patel on 09/06/23.
//

import SwiftUI
extension Views{
    struct CategoryView: View {
        @ObservedObject var viewModel: ViewModel
        let questionsViewModel: Views.QuestionView.ViewModel = .init()
        @State private var selectedDifficultyIndex = 0
        @State private var selectedCategoryIndex = 0
        @State private var selectedTypeIndex = 0
        @State var alert = false
        let columns = [
            GridItem(.fixed(190)),
            GridItem(.fixed(190)),
        ]
        var body: some View {
            NavigationView{
                VStack{
                    ZStack{
                        Color("Blue")
                            .edgesIgnoringSafeArea(.all)

                        Image("q1")
                            .resizable()
                            .frame(width: 150,height: 80)
                            .offset(x:-105,y:-165)

                        Image("q2")
                            .resizable()
                            .frame(width: 450,height: 220)
                            .offset(y:-20)

                    }
                    ZStack{
                   
                     ScrollView(.vertical) {
                     
                            LazyVGrid(columns: columns, spacing: 5) {
                                ForEach(0 ..< Manager.API.QuestionCategory.allCases.count, id: \.self) {cat in
                                    Button(action: {
                                        self.alert = true
                                        selectedCategoryIndex = cat

                                    }, label: {

                                        Text(Manager.API.QuestionCategory.allCases[cat].categoryName)
                                            .foregroundColor(cat == selectedCategoryIndex ? .white : Color("Blue"))
                                            .fontWeight(.bold)
                                            .frame(width: 140, height: 80)
                                            .background(cat == selectedCategoryIndex  ? Color("Blue") : Color.white)
                                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                            .padding(5)
                                    })
                                }
                            }
                            .offset(y:20)
                        }
                        .background(
                            Color("BlueLight1")
                                .clipShape(CustomCorner(corner: [.topLeft,.topRight], radius: 25))
                                .ignoresSafeArea()
                        )
                    }
                    .offset(y: -35)
                
                    .padding(.vertical,-52)
                 
                    VStack{
                       NavigationLink(destination: QuestionView(viewModel: questionsViewModel)
                        .navigationBarHidden(true)
                        .task {
                            do {
                                Manager.AnswerTracker.shared.startQuiz(questionAmount: viewModel.numberQuestions)
                                Manager.AnswerTracker.shared.startQuiz(questionAmount: viewModel.numberQuestions)
                                let questions = try await Manager.API.shared.fetchQuestions(
                                category: Manager.API.QuestionCategory.allCases[selectedCategoryIndex],  answerType: Manager.API.AnswerTypes.multiple,amount: viewModel.numberQuestions)
                                    questionsViewModel.update(question: questions.first!)
                                } catch {
                                        print(error)
                                        }
                                    }
                 
                                ){
                                    Text("Start Quiz")
                                       .font(.system(size: 22))
                                       .fontWeight(.bold)
                                       .foregroundColor(.white)
                                       .offset(y: -2)
                                       .background{
                                                    RoundedRectangle(cornerRadius: 8)
                                                    .fill(Color("Blue"))
                                                    .frame(width: 400, height: 55)
                            }
                        }
                    }
                    .offset(y:22)

                }
            }
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        Views.CategoryView(viewModel: .init())
    }
}
extension Views.CategoryView {
    class ViewModel: ObservableObject {
        @Published var numberQuestions: Int = 10 {
            didSet {
                if numberQuestions == 0 {
                    numberQuestions = 1
                }

                if numberQuestions == 51 {
                    numberQuestions = 50
                }
            }
        }
    }
}

