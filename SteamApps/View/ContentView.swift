//
//  ContentView.swift
//  SteamApps
//
//  Created by Vladislav Novoshinskiy on 26.05.2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appVM: AppViewModel
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(searchResult, id: \.appid) { item in
                        if item.name.count > 1 {
                            NavigationLink(destination: NewsListView(appid: item.appid, newsTitle: item.name)) {
                                HStack {
                                    Text(item.name)
                                        .foregroundColor(Color("textMain"))
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                }
                                .padding()
                                .frame(maxHeight: .infinity)
                                .background(Color("mainBG"))
                                .cornerRadius(10)
                            }
                        }
                    }
                }
            }
            .searchable(text: $searchText)
            .padding(.horizontal)
            .navigationTitle("Steam Apps")
            .refreshable {
                appVM.loadApp()
            }
            .task {
                appVM.loadApp()
            }
        }
    }
    
    var searchResult: [AppItem] {
        if let allApp = appVM.allApp {
            if searchText.isEmpty {
                return allApp.applist.apps
            } else {
                return allApp.applist.apps.filter { $0.name.contains(searchText)}
            }
        }
        return []
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppViewModel())
    }
}
