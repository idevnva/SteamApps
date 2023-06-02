//
//  NewsViewModel.swift
//  SteamApps
//
//  Created by Vladislav Novoshinskiy on 27.05.2023.
//

import Foundation

class NewsViewModel: ObservableObject {
    
    @Published var allNews: AllNews?
    
    // MARK: Загрузка новостей
    func loadNews(appid: Int32) {
        
        // Перекодировка ссылки
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.steampowered.com"
        urlComponents.path = "/ISteamNews/GetNewsForApp/v2/"
        urlComponents.queryItems =
        [
            URLQueryItem(name: "appid", value: "\(appid)"),
            URLQueryItem(name: "maxlength", value: "0")
        ]
        
        // проверка ссылки
        guard let url = urlComponents.url else { return }
        
        // загрузка новостей и распаковка
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            // проверка полученных данных
            guard let data = data, error == nil else { return }
            
            do {
                let allNews = try JSONDecoder().decode(AllNews.self, from: data)
                // в асинхронном паттоке записываем полученные данные
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
