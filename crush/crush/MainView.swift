//
//  ProfileView.swift
//  crush
//
//  Created by Fuhu Xiao on 10/12/19.
//  Copyright © 2019 Crush Inc. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @ObservableObject var state: AppState

    var body: some View {
        TabView {
            ProfileView(user: user)
                .tabItem {
                    Image(systemName: "1.square.fill")
                    Text("First")
                }
            ContentView()
                .tabItem {
                    Image(systemName: "2.square.fill")
                    Text("Second")
                }
            TabView() {
                ListView(userData: [User(id: 1, name: "AS", description: "DF", imageUrl: "https://i.imgur.com/FpYM3fM.jpg")], title: "Liked by")
                .tabItem {
                    Image(systemName: "star.fill")
                }
            }
                .tabItem {
                    Image(systemName: "3.square.fill")
                    Text("Third")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(user: User(id: 1, name: "AS", description: "DF", imageUrl: "foo"))
    }
}
