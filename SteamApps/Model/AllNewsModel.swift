//
//  AllNewsModel.swift
//  SteamApps
//
//  Created by Vladislav Novoshinskiy on 27.05.2023.
//

import Foundation

// MARK: - AllNews
struct AllNews: Codable {
    let appnews: AppNews
}

// MARK: - AppNews
struct AppNews: Codable {
    let appid: Int32
    let newsitems: [NewsItem]
    let count: Int32
}

// MARK: - NewsItem
struct NewsItem: Codable {
    let title, contents: String
    let appid: Int32
    let gid: String
}
