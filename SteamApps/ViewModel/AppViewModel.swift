//
//  AppViewModel.swift
//  SteamApps
//
//  Created by Vladislav Novoshinskiy on 26.05.2023.
//

import Foundation

class AppViewModel: ObservableObject {
    
    @Published var allApp: AllApps? {
        didSet  { self.searchResult = self.allApp?.applist.apps ?? [AppItem]() }
    }
    
    @Published var searchText = "" {
        didSet { filterApply() }
    }
    
    @Published var searchResult = [AppItem]()
    
    // MARK: Второй вариант фильтрации
    private func filterApply() {
        guard searchText.count > 0 else {
            searchResult = self.allApp?.applist.apps ?? [AppItem]()
            return
        }
        
        if let apps = self.allApp?.applist.apps {
            searchResult = apps.filter { $0.name.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    // MARK: Первый вариант фильтрации
    //    private func filterApply() {
    //        guard searchText.count > 0 else {
    //            searchResult = allApp?.applist.apps ?? [AppItem]()
    //            return
    //        }
    //
    //        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now()) {
    //            if let apps = self.allApp?.applist.apps {
    //                let list = apps.filter { $0.name.lowercased().contains(self.searchText.lowercased()) }
    //                DispatchQueue.main.asyncAfter(deadline: .now()) {
    //                    self.searchResult = list
    //                }
    //            }
    //        }
    //    }
    
    // MARK: Загрузка игр
    func loadApp() {
        
        // Перекодировка ссылки
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.steampowered.com"
        urlComponents.path = "/ISteamApps/GetAppList/v2"
        
        // проверка ссылки
        guard let url = urlComponents.url else { return }
        
        // загрузка новостей и распаковка
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            
            // проверка полученных данных
            guard let data = data, error == nil else { return }
            
            do {
                let allApp = try JSONDecoder().decode(AllApps.self, from: data)
                // в асинхронном паттоке записываем полученные данные
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
