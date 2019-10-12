//
//  ProfileView.swift
//  crush
//
//  Created by Fuhu Xiao on 10/12/19.
//  Copyright © 2019 Crush Inc. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var state: AppState

    var body: some View {
        TabView {
            ProfileView(user: state.user).tabItem {
                Image(systemName: "1.square.fill")
                Text("First")
            }
            SnapshotView(state: state).tabItem {
                Image(systemName: "2.square.fill")
                Text("Second")
            }
            TabView {
                ListView(userData: state.liked, title: "Liked by", state: state)
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Liked by")
                }
                MatchListView(userData: state.matched, title: "Matched", state: state)
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Matched")
                }
            }.tabItem {
                Image(systemName: "3.square.fill")
                Text("Third")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(state: AppState())
    }
}
