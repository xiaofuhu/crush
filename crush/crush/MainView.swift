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
        TabView {
            VStack {
                ProfileView(user: state.user)
                HStack {
                    TextField("User ID", text: $id)
                    Button(action: {
                        self.state.getUser(id: self.id) { user in
                            self.state.nearby.removeAll()
                            self.state.user = user
                        }
                    }) {
                        Text("Login")
                    }
                }
            }.tabItem {
                Image(systemName: "person.crop.square.fill")
            }
            SnapshotView(state: state).tabItem {
                Image(systemName: "map.fill")
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
                NearbyListView(userData: state.nearby, title: "Nearby", state: state)
                .tabItem {
                    Image(systemName: "globe")
                    Text("Nearby")
                }
            }.tabItem {
                Image(systemName: "list.dash")
            }
        }.imageScale(.large)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(state: AppState())
    }
}
