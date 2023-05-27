//
//  AppViewModel.swift
//  SteamApps
//
//  Created by Vladislav Novoshinskiy on 26.05.2023.
//

import Foundation

class AppViewModel: ObservableObject {
    @Published var allApp: AllApps?
    
    func loadApp() {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.steampowered.com"
        urlComponents.path = "/ISteamApps/GetAppList/v2"
        
        guard let url = urlComponents.url else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let allApp = try JSONDecoder().decode(AllApps.self, from: data)
                DispatchQueue.main.async {
                    self?.allApp = allApp
                }
            } catch {
                print(error as Any)
            }
        }
        task.resume()
    }
}
