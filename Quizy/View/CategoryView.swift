//
//  CategoryView.swift
//  Quizy
//
//  Created by Bhumika Patel on 09/06/23.
//

import SwiftUI

struct CategoryView: View {
    @State private var selectedCategoryIndex = 0
    let columns = [
            GridItem(.fixed(190)),
            GridItem(.flexible()),
        ]
    var body: some View {
        NavigationView{
            ZStack{
                Color("BG")
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(0 ..< Manager.API.QuestionCategory.allCases.count, id: \.self) {cat in
                                Button(action: {
                                    //   isPressed = true
                                }, label: {
                                    Text(Manager.API.QuestionCategory.allCases[cat].categoryName)
                                        .foregroundColor(cat == selectedCategoryIndex ? .white : .purple)
                                        .onTapGesture {
                                            selectedCategoryIndex = cat
                                        }
                                })
                                .padding()
                                .frame(width: 140, height: 80)
                                .background(cat == selectedCategoryIndex  ? Color.purple : Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                .onTapGesture {
                                    selectedCategoryIndex = cat
                                }
                                .padding()
                            }
                            // .padding()
                        }
                    }
                }
               // .padding()
            }
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
//extension CategoryView {
//    class ViewModel: ObservableObject {
//        @Published var numberQuestions: Int = 10 {
//            didSet {
//                if numberQuestions == 0 {
//                    numberQuestions = 1
//                }
//
//                if numberQuestions == 51 {
//                    numberQuestions = 50
//                }
//            }
//        }
//    }
//}
