//
//  HeroModel.swift
//  MarvelApp
//
//  Created by Georgiy on 24.01.2023.
//

import Foundation
import UIKit

// MARK: - Welcome
struct MarvelHero: Decodable {
    let data: DataClassHero
}

// MARK: - DataClass
struct DataClassHero: Decodable {
    let results: [ResultHero]
}

// MARK: - Result
struct ResultHero: Decodable {

    let thumbnail: ThumbnailHero
    let title: String
    let description: String?
    let prices: [Price]
}

// MARK: - Thumbnail
struct ThumbnailHero: Codable {
    let path: String
    let thumbnailExtension: ExtensionHero

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

enum ExtensionHero: String, Codable {
    case jpg = "jpg"
}

// MARK: - Price
struct Price: Codable {
    let type: PriceType
    let price: Double
}

enum PriceType: String, Codable {
    case digitalPurchasePrice = "digitalPurchasePrice"
    case printPrice = "printPrice"
}

extension ResultHero {
    func getThumbnailUrl() ->  String {
        let url = "\(thumbnail.path)" + "." + "\(thumbnail.thumbnailExtension.rawValue)"
        return url
    }
    
    func getComicPrice() -> String {
        let price = "\(String(describing: prices.first?.price ?? 4.99)) $"
        return price
    }
    
}
