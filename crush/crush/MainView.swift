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
    @State private var id: String = "1"

    var body: some View {
        TabView(selection: $state.selectedView) {
            VStack {
                ProfileView(user: state.user)
                HStack {
                    TextField("User ID", text: $id)
                       .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        self.state.getUser(id: self.id) { user in
                            self.state.nearby.removeAll()
                            self.state.user = user
                            self.state.manager.stopUpdatingLocation()
                            self.state.manager.startUpdatingLocation()
                        }
                    }) {
                        Text("Login")
                    }
                }
            }.tabItem {
                Image(systemName: "person.crop.square.fill")
            }.tag(0).padding()
            SnapshotView(state: state).tabItem {
                Image(systemName: "map.fill")
            }.tag(1)
            TabView(selection: $state.selectedView2) {
                ListView(userData: state.liked, title: "Liked by", state: state)
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Liked by")
                }.tag(0)
                MatchListView(userData: state.matched, title: "Matched", state: state)
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Matched")
                }.tag(1)
                NearbyListView(userData: state.nearby, title: "Nearby", state: state)
                .tabItem {
                    Image(systemName: "globe")
                    Text("Nearby")
                }.tag(2)
            }.tabItem {
                Image(systemName: "list.dash")
            }.tag(2)
        }
        .imageScale(.large)
        .edgesIgnoringSafeArea(.top)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(state: AppState())
    }
}
