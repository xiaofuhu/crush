//
//  ListView.swift
//  crush
//
//  Created by Alexander Zhang on 10/12/19.
//  Copyright © 2019 Crush Inc. All rights reserved.
//

import SwiftUI

struct ListView: View {
    var userData: [User]
    
    var body: some View {
        NavigationView {
            List(userData) { user in
                HStack {
                    Image(uiImage: user.image)
                    VStack {
                        Text(user.name).font(.title)
                        Text(user.description).font(.subheadline)
                    }
                }
            }
            .navigationBarTitle(Text("People"))
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(userData: [
            User(id: 0, name: "Foo", description: "An interesting person", imageUrl: "foo")])
    }
}
