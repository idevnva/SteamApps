//
//  AllApp.swift
//  SteamApps
//
//  Created by Vladislav Novoshinskiy on 26.05.2023.
//

import Foundation

// MARK: - AllApps
struct AllApps: Codable {
    let applist: AppList
}

// MARK: - AppList
struct AppList: Codable {
    let apps: [AppItem]
}

// MARK: - AppItem
struct AppItem: Codable {
    let appid: Int32
    let name: String
}
