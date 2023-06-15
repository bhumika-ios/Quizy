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

//Unlock your knowledge, one question at a time.
//Unlock Your Knowledge: Quiz with the Best
//Unlock Your Knowledge with QuizMaster: The Ultimate Quiz App Experience
var pageModel: [PageModel] = [
    .init(image: "P3", title: "Quiz with the Best", subTitle: ""),
    .init(image: "P1", title: "Explore knowledge", subTitle: "Explore various categories and expand your knowledge"),
    .init(image: "P2", title: "Climb leaderboard", subTitle: "Compete for the top score and climb the leaderboard", displayAction: true),
    
]
