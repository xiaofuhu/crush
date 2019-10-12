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
    var title: String
    
    var body: some View {
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
            }
            .navigationBarTitle(Text(title))
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(userData: [User(id: 0, name: "Foo",
            description: "An interesting person", imageUrl: "https://i.imgur.com/RMJtEhQ.jpg")
        ], title: "Nearby People")
    }
}

