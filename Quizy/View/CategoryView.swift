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
            GridItem(.fixed(100)),
            GridItem(.flexible()),
            
        ]
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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
