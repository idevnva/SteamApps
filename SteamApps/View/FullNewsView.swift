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
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    HStack {
                        Text(contents)
                        Spacer()
                    }
                    .padding()
                    .frame(maxHeight: .infinity)
                    .background(Color("mainBG"))
                    .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct FullNewsView_Previews: PreviewProvider {
    static var previews: some View {
        FullNewsView(title: "", contents: "")
    }
}
