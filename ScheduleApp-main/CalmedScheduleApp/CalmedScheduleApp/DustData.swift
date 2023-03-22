//
//  Dust.swift
//  CalmedScheduleApp
//
//  Created by Sam Sung on 2023/03/21.
//

import Foundation

// MARK: - Dust
struct Dust: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let body: Body
}

// MARK: - Body
struct Body: Codable {

    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let informGrade: String?
    let informData: String?
}

// MARK: - Encode/decode helpers
//
//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
    
//}
