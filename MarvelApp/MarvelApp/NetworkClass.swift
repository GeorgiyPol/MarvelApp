//
//  NetworkClass.swift
//  MarvelApp
//
//  Created by Georgiy on 25.01.2023.
//

import Foundation
import CryptoKit
import UIKit


struct MarvelStruct {
    
    var marvelScheme = "https"
    var marvelHost = "gateway.marvel.com"
    var marvelPath = "/v1/public/characters"
    var marvelName = String()
    
    var ts = "10"
    var publicKey = "31a63b3b088f1225ef9e5d5f56a97b85"
    var privateKey = "3adc415e071e5bc6db0bd003ad1ce215277ec73b"
    
    var dataToMD5: String {
        ts + privateKey + publicKey
    }
    
    func makeURL(scheme: String,
                 host: String,
                 path: String,
                 
                 queryItems: [URLQueryItem]?) -> String {
        
        var components = URLComponents()
        
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems
        
        guard let componentsString = components.string else { return "an error occurred in the line, double-check" }
        return componentsString
    }
    
    func MD5(string: String) -> String {
        
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }
}
