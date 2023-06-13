//
//  Color.swift
//  Quizy
//
//  Created by Bhumika Patel on 10/06/23.
//

import SwiftUI

extension DesignSystem {
    struct Color {
        public let uiColor: SwiftUI.Color

        public var color: Color {
            Color(uiColor: uiColor)
        }
    }
}

// swiftlint:disable:all cyclomatic_complexity
// swiftlint:disable:all function_body_length
extension DesignSystem.Color {
    static func byCategory(
        category: Manager.API.QuestionCategory) -> DesignSystem.Color {
        switch category {
        case .generalKnowledge:
                    return DesignSystem.Color(uiColor: .init(red: 221/255, green: 220/255, blue: 240/255))
//        case .entertainmentBooks:
//                    return DesignSystem.Color(uiColor: .init(red: 37/255, green: 65/255, blue: 130/255))
//        case .entertainmentFilms:
//                    return DesignSystem.Color(uiColor: .init(red: 234/255, green: 168/255, blue: 68/255))
//        case .entertainmentMusic:
//                    return DesignSystem.Color(uiColor: .init(red: 155/255, green: 193/255, blue: 64/255))
//        case .entertainmentMusicalsAndTheatres:
//                    return DesignSystem.Color(uiColor: .init(red: 159/255, green: 42/255, blue: 115/255))
//        case .entertainmentTelevision:
//                    return DesignSystem.Color(uiColor: .init(red: 33/255, green: 61/255, blue: 109/255))
//        case .entertainmentVideoGames:
//                    return DesignSystem.Color(uiColor: .init(red: 247/255, green: 200/255, blue: 75/255))
//        case .entertainmentBoardGames:
//                    return DesignSystem.Color(uiColor: .init(red: 159/255, green: 42/255, blue: 115/255))
        case .scienceAndNature:
                    return DesignSystem.Color(uiColor: .init(red: 155/255, green: 193/255, blue: 64/255))
        case .scienceComputers:
                    return DesignSystem.Color(uiColor: .init(red: 236/255, green: 173/255, blue: 75/255))
        case .scienceMathematics:
                    return DesignSystem.Color(uiColor: .init(red: 52/255, green: 64/255, blue: 94/255))
        case .mythology:
                    return DesignSystem.Color(uiColor: .init(red: 252/255, green: 235/255, blue: 130/255))
        case .sports:
                    return DesignSystem.Color(uiColor: .init(red: 78/255, green: 115/255, blue: 33/255))
        case .geography:
                    return DesignSystem.Color(uiColor: .init(red: 236/255, green: 173/255, blue: 75/255))
        case .history:
                    return DesignSystem.Color(uiColor: .init(red: 17/255, green: 43/255, blue: 95/255))
        case .politics:
                    return DesignSystem.Color(uiColor: .init(red: 70/255, green: 88/255, blue: 131/255))
        case .art:
                    return DesignSystem.Color(uiColor: .init(red: 159/255, green: 42/255, blue: 115/255))
//        case .celebrities:
//                    return DesignSystem.Color(uiColor: .init(red: 247/255, green: 200/255, blue: 75/255))
        case .animals:
                    return DesignSystem.Color(uiColor: .init(red: 221/255, green: 220/255, blue: 240/255))
//        case .vehicles:
//                    return DesignSystem.Color(uiColor: .init(red: 17/255, green: 43/255, blue: 95/255))
//        case .entertainmentComics:
//                    return DesignSystem.Color(uiColor: .init(red: 155/255, green: 193/255, blue: 64/255))
//        case .scienceGadgets:
//                    return DesignSystem.Color(uiColor: .init(red: 70/255, green: 88/255, blue: 131/255))
//        case .entertainmentAnimeAndMaga:
//                    return DesignSystem.Color(uiColor: .init(red: 80/255, green: 23/255, blue: 98/255))
//        case .entertainmentCartoonAndAnimations:
//                    return DesignSystem.Color(uiColor: .init(red: 80/255, green: 23/255, blue: 98/255))
//        case .all:
//            return DesignSystem.Color(uiColor: .clear)
        }
    }

    static func textColorByCategory(category: Manager.API.QuestionCategory) -> DesignSystem.Color {
        switch category {
//        case .all:
//            return DesignSystem.Color(uiColor: .red)
        case  .history,  .sports,
                .scienceMathematics:
            return DesignSystem.Color(uiColor: .white)
        default:
            return DesignSystem.Color(uiColor: .black)
        }
    }
}

extension DesignSystem.Color {
    enum ColorCategory {

    }
    enum System {
        static let basicColor = DesignSystem.Color(uiColor: .init(red: 132/255, green: 196/255, blue: 164/255))
        static let launchColor = DesignSystem.Color(uiColor: .init(red: 151/255, green: 191/255, blue: 178/255))
        static let logoFontColor = DesignSystem.Color(uiColor: .init(red: 90/255, green: 144/255, blue: 131/255))
    }
}
