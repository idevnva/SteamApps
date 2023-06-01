//
//  ContentView.swift
//  SteamApps
//
//  Created by Vladislav Novoshinskiy on 26.05.2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var appVM = AppViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(appVM.searchResult, id: \.appid) { item in
                        if item.name.count > 0 {
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
            .searchable(text: $appVM.searchText)
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
