//
//  ContentView.swift
//  Quizy
//
//  Created by Bhumika Patel on 09/06/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
      //   Views.MainView(viewModel: .init())
            Views.CategoryView(viewModel: .init())
        }
       // .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
