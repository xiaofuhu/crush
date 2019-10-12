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
                ListView(userData: state.nearby, title: "Nearby", state: state)
                .tabItem {
                    Image(systemName: "globe")
                    Text("Nearby")
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
