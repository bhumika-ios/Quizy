//
//  APIManager.swift
//  Quizy
//
//  Created by Bhumika Patel on 09/06/23.
//

import Foundation
import SwiftUI

extension Manager {
    struct API {
        public static var shared = Manager.API()
        var questions: [Question] = []

        enum QuestionError: Error {
            case badURL
            case badResponse
            case noData
            case decodingError
            case invalidCategory
        }

//        enum Difficulty: String, CaseIterable {
//            case any
//            case easy
//            case medium
//            case hard
//        }

        enum AnswerTypes: CaseIterable {
            case any
            case multiple
            case boolean

            static func withLabel(_ label: String) -> AnswerTypes {
                let caseResult = self.allCases.first {
                    $0.rawValue == label
                }
                guard let caseResult = caseResult else {
                    return .multiple
                }
                return caseResult
            }

            var answerTypeName: String {
                switch self {
                case .any:
                    return "Any question type"
                case .multiple:
                    return "Multiple Choices"
                case .boolean:
                    return "Right or Wrong"
                }
            }

            var rawValue: String {
                switch self {
                case .any:
                    return "any"
                case .multiple:
                    return "multiple"
                case .boolean:
                    return "boolean"
                }
            }
        }

        func queryBuilder(
//            difficulty: Difficulty,
            category: QuestionCategory,
            answerType: AnswerTypes,
            amount: Int = 10
        ) throws -> URL {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "opentdb.com"
            components.path = "/api.php"

            var queryItems: [URLQueryItem] = [
                URLQueryItem(name: "amount", value: String(amount))
            ]

//            if difficulty != .any {
//                queryItems.append(URLQueryItem(name: "difficulty", value: difficulty.rawValue as String))
//            }

            if category != .generalKnowledge {
                queryItems.append(URLQueryItem(name: "category", value: String(category.categoryId)))
            }

            if answerType != .multiple {
                queryItems.append(URLQueryItem(name: "type", value: answerType.rawValue))
            }

            components.queryItems = queryItems
            guard let url = components.url else { throw QuestionError.badURL }
            return url
        }

        mutating func fetchQuestions(
            category: QuestionCategory,
//            difficulty: Difficulty,
            answerType: AnswerTypes,
            amount: Int = 10
        ) async throws -> [Question] {
            let url = try queryBuilder(
//                difficulty: difficulty,
                category: category,
                answerType: answerType,
                amount: amount
            )
            let session = URLSession(configuration: .ephemeral)
            let (data, response) = try await(session.data(from: url))
            guard let response = response as? HTTPURLResponse else { throw QuestionError.badResponse }
            guard response.statusCode == 200 else { throw QuestionError.badResponse }
            let result = try JSONDecoder().decode(Response.self, from: data)
            let questions = Manager.API.parseResponse(questions: result.results)
            self.questions = questions
            return questions
        }

        static func parseResponse(questions: [Manager.API.QuestionAPI]) -> [Question] {
            return questions.map { question in
                return Question(
                    category: QuestionCategory.withLabel(question.category),
                    type: AnswerTypes.withLabel(question.type),
                    difficulty: question.difficulty,
                    question: question.question.html2String,
                    correct_answer: question.correct_answer.html2String,
                    incorrect_answers: question.incorrect_answers.map { answer in
                        return answer.html2String
                    }
                )
            }
        }
    }
}

// swiftlint:disable:all identifier_name
public struct Question {
    let category: Manager.API.QuestionCategory
    let type: Manager.API.AnswerTypes
    let difficulty: String
    let question: String
    let correct_answer: String
    let incorrect_answers: [String]
}

// swiftlint:disable:all identifier_name
extension Manager.API {
    struct Response: Codable {
        let response_code: Int
        let results: [QuestionAPI]
    }

    struct QuestionAPI: Codable {
        let category: String
        let type: String
        let difficulty: String
        let question: String
        let correct_answer: String
        let incorrect_answers: [String]
    }
}

extension Manager.API {
    public enum QuestionCategory: CaseIterable {
 //       case all
        case generalKnowledge
//        case entertainmentBooks
//        case entertainmentFilms
//        case entertainmentMusic
//        case entertainmentMusicalsAndTheatres
//        case entertainmentTelevision
//        case entertainmentVideoGames
//        case entertainmentBoardGames
        case scienceAndNature
        case scienceComputers
        case scienceMathematics
        case mythology
        case sports
        case geography
        case history
        case politics
        case art
//        case celebrities
        case animals
//        case vehicles
//        case entertainmentComics
//        case scienceGadgets
//        case entertainmentAnimeAndMaga
//        case entertainmentCartoonAndAnimations

        static func withLabel(_ label: String) -> QuestionCategory {
            let caseResult = self.allCases.first {
                $0.categoryName == label
            }
            guard let caseResult = caseResult else {
                return .generalKnowledge
            }
            return caseResult
        }

        var categoryName: String {
            switch self {
//            case .all:
//                return "All"
            case .generalKnowledge:
                return "General Knowledge"
//            case .entertainmentBooks:
//                return "Entertainment: Books"
//            case .entertainmentFilms:
//                return "Entertainment: Film"
//            case .entertainmentMusic:
//                return "Entertainment: Music"
//            case .entertainmentMusicalsAndTheatres:
//                return "Entertainment: Musicals & Theatres"
//            case .entertainmentTelevision:
//                return "Entertainment: Television"
//            case .entertainmentVideoGames:
//                return "Entertainment: Video Games"
//            case .entertainmentBoardGames:
//                return "Entertainment: Board Games"
            case .scienceAndNature:
                return "Science & Nature"
            case .scienceComputers:
                return "Science: Computers"
            case .scienceMathematics:
                return "Science: Mathematics"
            case .mythology:
                return "Mythology"
            case .sports:
                return "Sports"
            case .geography:
                return "Geography"
            case .history:
                return "History"
            case .politics:
                return "Politics"
            case .art:
                return "Art"
//            case .celebrities:
//                return "Celebrities"
            case .animals:
                return "Animals"
//            case .vehicles:
//                return "Vehicles"
//            case .entertainmentComics:
//                return "Entertainment: Comics"
//            case .scienceGadgets:
//                return "Science: Gadgets"
//            case .entertainmentAnimeAndMaga:
//                return "Entertainment: Japanese Anime & Manga"
//            case .entertainmentCartoonAndAnimations:
//                return "Entertainment: Cartoon & Animations"
            
            }
        }

        var categoryId: Int {
            switch self {
//            case .all:
//                return 0
            case .generalKnowledge:
                return 9
//            case .entertainmentBooks:
//                return 10
//            case .entertainmentFilms:
//                return 11
//            case .entertainmentMusic:
//                return 12
//            case .entertainmentMusicalsAndTheatres:
//                return 13
//            case .entertainmentTelevision:
//                return 14
//            case .entertainmentVideoGames:
//                return 15
//            case .entertainmentBoardGames:
//                return 16
            case .scienceAndNature:
                return 17
            case .scienceComputers:
                return 18
            case .scienceMathematics:
                return 19
            case .mythology:
                return 20
            case .sports:
                return 21
            case .geography:
                return 22
            case .history:
                return 23
            case .politics:
                return 24
            case .art:
                return 25
//            case .celebrities:
//                return 26
            case .animals:
                return 27
//            case .vehicles:
//                return 28
//            case .entertainmentComics:
//                return 29
//            case .scienceGadgets:
//                return 30
//            case .entertainmentAnimeAndMaga:
//                return 31
//            case .entertainmentCartoonAndAnimations:
//                return 32
            }
        }
    }
}
