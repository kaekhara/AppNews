//
//  Article.swift
//  AppNews
//
//  Created by Beibarys Yermakhan on 15.12.2024.
//

import Foundation

struct NewsResponse: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String?
}
