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
    @Published var user = User(id: 0, name: "", description: "", imageUrl: "")
    fileprivate var db: DatabaseReference!
    fileprivate var gdb: GeoFire!

    func capture(closure: () -> Void) {
        let location = manager.location.coordinate
        var query = gdb.queryAtLocation(location, withRadius: 0.1)
        query.observeEventType(.KeyEntered, withBlock: { key, _ in
            guard (key != user.id) else { return }
            getUser(key) { nearby.append(newElement: $0) }
        })
        query.observeReadyWithBlock(closure)
    }
    
    func sendLocation() {
        let location = manager.location.coordinate
        gdb.setLocation(location, forKey: userId)
    }
    
    func getUser(id: String, closure: (User) -> Void) {
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
