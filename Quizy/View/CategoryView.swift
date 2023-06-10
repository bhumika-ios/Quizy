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
                        Color("Blue")
                        .edgesIgnoringSafeArea(.all)
                     //   VStack{
                            ScrollView() {
                                LazyVGrid(columns: columns, spacing: 10) {
                                    ForEach(0 ..< Manager.API.QuestionCategory.allCases.count, id: \.self) {cat in
                                        Button(action: {
                                            //   isPressed = true
                                        }, label: {
                                            Text(Manager.API.QuestionCategory.allCases[cat].categoryName)
                                                .foregroundColor(cat == selectedCategoryIndex ? .white : Color("Blue"))
                                                .fontWeight(.bold)
                                                .onTapGesture {
                                                    selectedCategoryIndex = cat
                                                }
                                        })
                                      //  .padding()
                                        .frame(width: 140, height: 80)
                                        .background(cat == selectedCategoryIndex  ? Color("Blue") : Color.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                        .onTapGesture {
                                            selectedCategoryIndex = cat
                                        }
                                        .padding(10)
                                    }
                                    // .padding()
                                }
                            }
                          //  .frame(maxWidth:.infinity , maxHeight: .infinity)
                            .background(
                                Color("BlueLight1")
                                // apply custom corner
                                    .clipShape(CustomCorner(corner: [.topLeft,.topRight], radius: 25))
                                    .ignoresSafeArea()
                            )
                      //  }
                         .padding()
                         
                    }
                    .padding(.vertical,-85)
              //  }
            }
            
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
