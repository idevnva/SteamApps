//
//  SteamAppsApp.swift
//  SteamApps
//
//  Created by Vladislav Novoshinskiy on 26.05.2023.
//

import SwiftUI

@main
struct SteamAppsApp: App {
    @ObservedObject var appVM = AppViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appVM)
        }
    }
}
