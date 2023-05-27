//
//  NoNewsView.swift
//  SteamApps
//
//  Created by Vladislav Novoshinskiy on 27.05.2023.
//

import SwiftUI

struct NoNewsView: View {
    var body: some View {
        VStack(alignment: .center) {
            Text("😊")
                .font(.system(size: 32))
            HStack {
                Spacer()
                Text("Sorry, no news yet, check back later.")
                Spacer()
            }
        }
        .padding()
        .frame(maxHeight: .infinity)
        .background(Color("mainBG"))
        .cornerRadius(10)
    }
}

struct NoNewsView_Previews: PreviewProvider {
    static var previews: some View {
        NoNewsView()
    }
}
