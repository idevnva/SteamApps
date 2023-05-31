//
//  FullNewsView.swift
//  SteamApps
//
//  Created by Vladislav Novoshinskiy on 27.05.2023.
//

import SwiftUI

struct FullNewsView: View {
    @EnvironmentObject var newsVM: NewsViewModel
    
    @State var title: String
    @State var contents: String
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HTMLView(htmlString: contents)
            }
            .padding()
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct FullNewsView_Previews: PreviewProvider {
    static var previews: some View {
        FullNewsView(title: "title", contents: "contents")
            .environmentObject(NewsViewModel())
    }
}
