//
//  ListView.swift
//  crush
//
//  Created by Alexander Zhang on 10/12/19.
//  Copyright © 2019 Crush Inc. All rights reserved.
//

import SwiftUI
import UIKit

struct ListView: View {
    var userData: [User]
    var title: String! = "People"
    @ObservedObject var state: AppState
    
    var body: some View {
        NavigationView {
            List(userData) { user in
                HStack() {
                    Image(uiImage: user.image)
                        .resizable()
                        .frame(width: 80, height: 80, alignment: .leading)
                    VStack {
                        Text(user.name).font(.title)
                    }
                    Spacer()
                    NavigationLink(destination: OtherProfileView(user: user, state: self.state)) {
                        Spacer()
                        Text("View")
                    }
                    Spacer()
                }
            }.navigationBarTitle(Text(title))
        }
    }
}

struct NearbyListView: View {
    var userData: [User]
    var title: String! = "People"
    @ObservedObject var state: AppState
    
    var body: some View {
        NavigationView {
            List(userData) { user in
                HStack() {
                    Image(uiImage: user.image)
                        .resizable()
                        .frame(width: 80, height: 80, alignment: .leading)
                    VStack {
                        Text(user.name).font(.title)
                    }
                    Spacer()
                    NavigationLink(destination: NearbyProfileView(user: user, state: self.state)) {
                        Spacer()
                        Text("View")
                    }
                    Spacer()
                }
            }.navigationBarTitle(Text(title))
        }
    }
}

struct NearbyProfileView: View {
    var user: User
    @ObservedObject var state: AppState
    
    var body: some View {
        VStack {
            ProfileView(user: user)
            Spacer()
            Button(action: { self.state.like(id: self.user.id) }) {
                Text("Like").fontWeight(.bold).font(.system(size: 20)).lineSpacing(20)
            }
            Spacer()
        }
    }
}

struct OtherProfileView: View {
    var user: User
    @ObservedObject var state: AppState
    
    var body: some View {
        VStack {
            ProfileView(user: user)
            Spacer()
            Button(action: { self.state.like_back(id: self.user.id) }) {
                Text("Like Back").fontWeight(.bold).font(.system(size: 20)).lineSpacing(20)
            }
            Spacer()
        }
    }
}

struct MatchListView: View {
    var userData: [User]
    var title: String! = "People"
    @ObservedObject var state: AppState
    
    var body: some View {
        NavigationView {
            List(userData) { user in
                HStack() {
                    Image(uiImage: user.image)
                        .resizable()
                        .frame(width: 80, height: 80, alignment: .leading)
                    VStack {
                        Text(user.name).font(.title)
                    }
                    Spacer()
                    NavigationLink(destination: ProfileView(user: user)) {
                        Spacer()
                        Text("View")
                    }
                    Spacer()
                }
            }.navigationBarTitle(Text(title))
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User(id: "0", name: "Foo", description: "An interesting person", imageUrl: "https://i.imgur.com/RMJtEhQ.jpg")
        return ListView(userData: [user], title: "Nearby People", state: AppState())
    }
}

