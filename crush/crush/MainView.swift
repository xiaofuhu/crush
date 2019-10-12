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
            SnapshotView(state: state).tabItem {
                Image(systemName: "2.square.fill")
                Text("Second")
            }
            ProfileView(user: state.user).tabItem {
                Image(systemName: "1.square.fill")
                Text("First")
            }
            ListView(userData: state.liked, title: "Liked by").tabItem {
                Image(systemName: "star.fill")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(state: AppState())
    }
}
