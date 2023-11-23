//
//  News.swift
//  CaploitteNews
//
//  Created by Asanka Gankewala on 11/22/23.
//

import Foundation

public struct News: Codable {
    
    let status: String?
    let totalResults: Int?
    let articles: [Articles]?
    
    enum CodingKeys: String, CodingKey {
        case status
        case totalResults
        case articles
    }
}

public struct Articles: Codable {
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
    enum CodingKeys: String, CodingKey {
        case source
        case author
        case title
        case description
        case url
        case urlToImage
        case publishedAt
        case content
    }
}

public struct Source: Codable {
    
    let id: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
