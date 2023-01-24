//
//  MarvelModel.swift
//  MarvelApp
//
//  Created by Georgiy on 17.01.2023.
//

import Foundation

// MARK: - Welcome
struct Welcome: Decodable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Decodable {
    let results: [Result]
}

// MARK: - Result
struct Result: Decodable {
    let name: String
    let thumbnail: Image
    let id: Int
}

// MARK: - Thumbnail
struct Image: Decodable {
    let path: String
    let thumbnailExtension: Extension

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

enum Extension: String, Decodable {
    case gif = "gif"
    case jpg = "jpg"
}

extension Result {
    func getThumbnailUrl() ->  String {
        let url = "\(thumbnail.path)" + "." + "\(thumbnail.thumbnailExtension.rawValue)"
        return url
    }
}
