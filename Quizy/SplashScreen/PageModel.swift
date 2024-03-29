//
//  PageModel.swift
//  Quizy
//
//  Created by Bhumika Patel on 15/06/23.
//

import SwiftUI

struct PageModel: Identifiable, Hashable{
    var id : UUID = .init()
    var image: String
    var title: String
    var subTitle: String
    var displayAction: Bool = false
    
}

var pageModel: [PageModel] = [
    .init(image: "quiz1", title: "Explore knowledge", subTitle: "Explore various categories and expand your knowledge"),
    .init(image: "P1", title: "Test Your Knowledge", subTitle: "Quiz with descriptions to test your knowledge"),
    .init(image: "P2", title: "Climb leaderboard", subTitle: "Compete for the top score and climb the leaderboard", displayAction: true),
    
]
