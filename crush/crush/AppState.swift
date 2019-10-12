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
    @Published var liked: [User] = []
    @Published var user = User(id: "0", name: "", description: "", imageUrl: "")
    fileprivate var db = Database.database().reference()
    fileprivate var gdb = GeoFire(firebaseRef: Database.database().reference())

    func capture() {
        let query = gdb.query(at: manager.location!, withRadius: 0.1)
        query.observe(.keyEntered, with: { key, _ in
            guard (key != self.user.id) else { return }
            self.getUser(id: key) { self.nearby.append($0) }
        })
    }
    
    func sendLocation() {
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
        })
    }
}

// fetch list of all snapshots from server
