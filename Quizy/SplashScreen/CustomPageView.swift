//
//  CustomPageView.swift
//  Quizy
//
//  Created by Bhumika Patel on 15/06/23.
//

import SwiftUI

struct CustomPageView: View {
    var totalPage: Int
    var currentPage: Int
    var activeTint: Color = .black
    var inActiveTint: Color = .gray.opacity(0.5)
    var body: some View {
        HStack(spacing: 8){
            ForEach(0..<totalPage, id: \.self){
                Circle()
                    .fill(currentPage == $0 ? activeTint :inActiveTint)
                    .frame(width: 4, height: 4)
            }
        }
    }
}

struct CustomPageView_Previews: PreviewProvider {
    static var previews: some View {
        Page()
    }
}

