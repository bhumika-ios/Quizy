//
//  Page.swift
//  Quizy
//
//  Created by Bhumika Patel on 15/06/23.
//

import SwiftUI

struct Page: View {
    @State private var activePage: PageModel = pageModel[0]
    var body: some View {
        NavigationView{
            ZStack{
                Color("BlueLight1")
                    .edgesIgnoringSafeArea(.all)
                GeometryReader{
                    let size = $0.size
                    PageView(page: $activePage, size: size){
                        VStack{
                            VStack{
                                Spacer()
                                NavigationLink(destination:  Views.CategoryView(viewModel: .init()).navigationBarHidden(true)){
                                    Text("Get Strtated")
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                        .padding(.vertical, 15)
                                        .frame(maxWidth: .infinity)
                                        .background{
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(Color("Blue"))
                                                .frame(width: 165, height: 45)
                                            
                                        }
                                }
                            }
                            .padding(.top)
                        }
                    }
                }
                .padding(15)
            }
        }
    }
}

struct Page_Previews: PreviewProvider {
    static var previews: some View {
        
        Page()
    }
}
struct PageView<ActionView: View>: View{
    
    @Binding var page: PageModel
    var size: CGSize
    var actionView: ActionView
    init(page: Binding<PageModel>, size: CGSize, @ViewBuilder actionView: @escaping () -> ActionView) {
        self._page = page
        self.size = size
        self.actionView = actionView()
    }
    @State private var showView: Bool = false
    @State private var wholeView: Bool = false
    var body: some View{
        
        VStack{
            GeometryReader{
                let size = $0.size
                
                Image(page.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 350, height: 400)
            }
            .offset(y: showView ? 0 : -size.height / 2)
            .opacity(showView ? 1 : 0)
            
            VStack(alignment:.leading, spacing: 10){
             //   Spacer(minLength: 0)
                Text(page.title)
                    .font(.system(size: 40))
                    .fontWeight(.semibold)
                Text(page.subTitle)
                  
                if !page.displayAction{
                    Group{
                        Spacer(minLength: 25)
//                        CustomPageView(totalPage: filteredPages.count, currentPage: filteredPages.firstIndex(of: page) ?? 0)
//                            .frame(maxWidth: .infinity)
                        
                        Spacer(minLength: 5)
                        
                        Button{
                            changePage()
                        }label: {
                            Text("Next")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: size.width * 0.4)
                                .padding(.vertical, 15)
                                .background{
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color("Blue"))
                                        .frame(width: 165, height: 45)
                                    
                                }
                        }
                        .frame(maxWidth: .infinity)
                        .offset(y: -75)
                    }
                }else{
                    actionView
                        .offset(y: showView ? 0 : size.height / 2)
                        .opacity(showView ? 1 : 0)
                        .offset(y: -75)
                    
                }
                  
            }
            .frame(maxWidth:.infinity, alignment: .leading)
            
            .offset(y: showView ? 0 : size.height / 2)
            .opacity(showView ? 1 : 0)
        }
        .offset(y:50)
        .offset(y: wholeView ? size.height / 2 : 0)
        .opacity(wholeView ? 0 : 1)
//        .overlay(alignment: .topLeading){
//            if page != pageModel.first{
//                Button{
//                    changePage(true)
//                } label: {
//                    Image(systemName: "chevron.left")
//                        .font(.title2)
//                        .fontWeight(.semibold)
//                        .foregroundColor(.black)
//                        .contentShape(Rectangle())
//                }
//                .padding(10)
//                .offset(y: showView ? 0 : -200)
//                .offset(y: wholeView ? -200 : 0)
//            }
//        }
        .onAppear{
            withAnimation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0).delay(0.1)){
                showView = true
            }
        }
    }
    func changePage(_ isPrev: Bool = false){
       
        withAnimation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0)){
            wholeView = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if let index = pageModel.firstIndex(of: page), (isPrev ? index != 0 : index != pageModel.count - 1 ) {
                page = isPrev ? pageModel[index - 1] : pageModel[index + 1]
            } else{
                page = isPrev ? pageModel[0] : pageModel[pageModel.count - 1]
            }
            wholeView = false
            showView = false
            
            withAnimation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0)){
                showView = true
            }
            
        }
      
    }
    var filteredPages: [PageModel] {
        return pageModel.filter{ !$0.displayAction }
    }
}

