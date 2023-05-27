//
//  NewsListView.swift
//  SteamApps
//
//  Created by Vladislav Novoshinskiy on 27.05.2023.
//

import SwiftUI

struct NewsListView: View {
    @StateObject var newsVM = NewsViewModel()
    
    @State var appid: Int32
    @State var newsTitle: String
    
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack {
                    Text(newsTitle)
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }
                LazyVStack(alignment: .leading) {
                    if let allNews = newsVM.allNews {
                        if allNews.appnews.count == 0 {
                            NoNewsView()
                        } else {
                            ForEach(allNews.appnews.newsitems, id: \.title) { item in
                                NavigationLink(destination: FullNewsView(title: item.title, contents: item.contents)) {
                                    HStack {
                                        Text(item.title)
                                            .foregroundColor(Color("textMain"))
                                        Spacer()
                                    }
                                }
                                .padding()
                                .frame(maxHeight: .infinity)
                                .background(Color("mainBG"))
                                .cornerRadius(10)
                            }
                        }
                    } else {
                        NoNewsView()
                    }
                }
            }
        }
        .padding(.horizontal)
        .navigationTitle("News")
        .navigationBarTitleDisplayMode(.inline)
        .refreshable {
            newsVM.loadNews(appid: appid)
        }
        .task {
            newsVM.loadNews(appid: appid)
        }
    }
}


struct NewsListView_Previews: PreviewProvider {
    static var previews: some View {
        NewsListView(appid: 2154000, newsTitle: "App")
    }
}

