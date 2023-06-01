//
//  NewsViewModel.swift
//  SteamApps
//
//  Created by Vladislav Novoshinskiy on 27.05.2023.
//

import Foundation

class NewsViewModel: ObservableObject {
    @Published var allNews: AllNews?
    
    func loadNews(appid: Int32) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.steampowered.com"
        urlComponents.path = "/ISteamNews/GetNewsForApp/v2/"
        urlComponents.queryItems =
        [
            URLQueryItem(name: "appid", value: "\(appid)"),
            URLQueryItem(name: "maxlength", value: "0")
        ]
        
        guard let url = urlComponents.url else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let allNews = try JSONDecoder().decode(AllNews.self, from: data)
                DispatchQueue.main.async {
                    self.allNews = allNews
                    print(allNews)
                }
            } catch {
                print(error as Any)
            }
        }
        task.resume()
    }
}
