//
//  Snapshot.swift
//  crush
//
//  Created by Alexander Zhang on 10/12/19.
//  Copyright © 2019 Crush Inc. All rights reserved.
//

import Foundation
import FirebaseDatabase
import CoreLocation
import GeoFire

final class AppState: ObservableObject {
    @Published var manager = CLLocationManager()
    @Published var nearby: [User] = []
    @Published var liked: [User] = [User(id: "3", name: "Laura", description: "I love math", imageUrl: "https://i.imgur.com/s0dmtAE.jpg")]
    @Published var matched: [User] = []
    @Published var user = User(id: "1", name: "", description: "", imageUrl: "")
    fileprivate var db = Database.database().reference()
    fileprivate var gdb = GeoFire(firebaseRef: Database.database().reference())

    func capture() {
        self.nearby.removeAll()
        let query = gdb.query(at: manager.location!, withRadius: 0.1)
        query.observe(.keyEntered, with: { key, _ in
            // guard (key != self.user.id) else { return }
            self.getUser(id: key) { self.nearby.append($0) }
        })
    }
    
    func sendLocation() {
        print("Sending location")
        gdb.setLocation(manager.location!, forKey: user.id)
    }
    
    func getUser(id: String, closure: @escaping (User) -> Void) {
        db.child("user").child(id).observeSingleEvent(of: .value, with: { snapshot in
            var user = User(id: id, name: "", description: "", imageUrl: "")
            let value = snapshot.value as? NSDictionary
            user.name = value?["name"] as? String ?? ""
            user.description = value?["description"] as? String ?? ""
            user.imageUrl = value?["image"] as? String ?? ""
            closure(user)
            print(user.id)
        })
    }
    
    func like_back(id: String) {
        db.child("user").child(id).child("match_list").child(user.id).setValue(1)
        db.child("user").child(user.id).child("match_list").child(id).setValue(1)
        db.child("user").child(id).observeSingleEvent(of: .value, with: { snapshot in
            var tmp = User(id: id, name: "", description: "", imageUrl: "")
            let value = snapshot.value as? NSDictionary
            tmp.name = value?["name"] as? String ?? ""
            tmp.description = value?["description"] as? String ?? ""
            tmp.imageUrl = value?["image"] as? String ?? ""
            self.matched.append(tmp)
        })
    }
}

// fetch list of all snapshots from server
