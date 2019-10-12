//
//  ProfileView.swift
//  crush
//
//  Created by Fuhu Xiao on 10/12/19.
//  Copyright © 2019 Crush Inc. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseDatabase

struct ProfileView: View {
    var user: User
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Image(uiImage: user.image).resizable()
                .shadow(radius: 10)
                .clipShape(Rectangle())
                .frame(width: 160, height: 160, alignment: .center)
                .cornerRadius(20, antialiased: true)
            Text(user.name).fontWeight(.semibold).font(.system(size: 40))
            Text(user.description).fontWeight(.semibold)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User(id: "0", name: "Foo", description: "An interesting person", imageUrl: "https://i.imgur.com/RMJtEhQ.jpg")
        return ProfileView(user: user)
    }
}
