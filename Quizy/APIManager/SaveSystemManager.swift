//
//  SaveSystemManager.swift
//  Quizy
//
//  Created by Bhumika Patel on 09/06/23.
//

import Foundation

extension Manager {
    class SaveSystem {
        enum SaveSystemError: Error {
            case invalidDirPath
            case fileDoesNotExist
            case failedWriting
            case failedReading
            case invalidStringEncoding
            case invalidObject
        }

        static func fileExists(fileName: String) -> Bool {
            guard let dirUrl = try? FileManager.default.url(for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true)
            else {
                return false
            }

            let fileUrl = dirUrl.appendingPathComponent(fileName)
                                .appendingPathExtension("json")
            return FileManager.default.fileExists(atPath: fileUrl.path)
        }

        static func saveToFile(content: String, fileName: String) throws {
            guard let dirUrl = try? FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true)
            else {
                throw SaveSystemError.invalidDirPath
            }

            let fileUrl = dirUrl.appendingPathComponent(fileName)
                                .appendingPathExtension("json")

            do {
                try content.write(to: fileUrl,
                                     atomically: true,
                                     encoding: String.Encoding.utf8)
            } catch {
                throw SaveSystemError.failedWriting
            }
        }

        static func readFromFile(fileName: String) throws -> String {
            guard let dirUrl = try? FileManager.default.url(for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true)
            else {
                throw SaveSystemError.invalidDirPath
            }

            let fileUrl = dirUrl.appendingPathComponent(fileName)
                                .appendingPathExtension("json")

            guard FileManager.default.fileExists(atPath: fileUrl.path)
            else {
                throw SaveSystemError.fileDoesNotExist
            }

            do {
                let fileContents = try String(contentsOf: fileUrl)
                return fileContents
            } catch {
                throw SaveSystemError.failedReading
            }
        }

        static func objectFromJson<T: Decodable>(json: String) throws -> T {
            guard let jsonData = json.data(using: .utf8)
            else {
                throw SaveSystemError.invalidStringEncoding
            }

            let decoder = JSONDecoder()
            do {
                return try decoder.decode(T.self, from: jsonData)
            } catch {
                throw SaveSystemError.invalidObject
            }
        }

        static func objectToJson<T: Encodable>(object: T) throws -> String {
            do {
                let jsonData = try JSONEncoder().encode(object)
                guard let stringData = String(data: jsonData, encoding: .utf8)
                else {
                    throw SaveSystemError.invalidStringEncoding
                }
                return stringData
            } catch {
                throw SaveSystemError.invalidObject
            }
        }

        static func saveObject<T: Encodable>(object: T, fileName: String) throws {
            let objectJson = try objectToJson(object: object)
            try saveToFile(content: objectJson, fileName: fileName)
        }

        static func readObject<T: Decodable>(fileName: String) throws -> T {
            let objectJson = try readFromFile(fileName: fileName)
            return try objectFromJson(json: objectJson)
        }
    }
}
