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
    @Published var matched: [User] = []
    @Published var user = User(id: "1", name: "", description: "", imageUrl: "")
    @Published var selectedView = 1
    @Published var selectedView2 = 0
    fileprivate var db = Database.database().reference()
    fileprivate var gdb = GeoFire(firebaseRef: Database.database().reference())

    func capture() {
        self.nearby.removeAll()
        let query = gdb.query(at: manager.location!, withRadius: 0.1)
        query.observe(.keyEntered, with: { key, _ in
            guard (key != self.user.id) else { return }
            self.getUser(id: key) { self.nearby.append($0) }
        })
        query.observeReady {
            self.selectedView = 2
            self.selectedView2 = 2
        }
    }
    
    func sendLocation() {
        print("Sending location")
        gdb.setLocation(manager.location!, forKey: user.id)
    }
    
    func getUser(id: String, closure: @escaping (User) -> Void) {
        db.child("user").child(id).observeSingleEvent(of: .value, with: { result in
            var user = User(id: id, name: "", description: "", imageUrl: "")
            let value = result.value as? NSDictionary
            user.name = value?["name"] as? String ?? ""
            user.description = value?["description"] as? String ?? ""
            user.imageUrl = value?["image"] as? String ?? ""
            closure(user)
        })
    }
    
    func like_back(id: String) {
        guard (matched.allSatisfy { $0.id != user.id }) else { return }
        db.child("user").child(id).child("match_list").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as! NSArray
            value.adding(NSNumber(value: Int(self.user.id)!)) // main user to other user
            self.db.child("user").child(id).child("match_list").setValue(value)
            self.getUser(id: id) { self.matched.append($0) }
            self.liked.removeAll { $0.id == id }
        })
        db.child("user").child(user.id).child("match_list").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as! NSArray
            value.adding(NSNumber(value: Int(id)!)) // other user to main user
            self.db.child("user").child(self.user.id).child("match_list").setValue(value)
        })
    }
    
    func like(id: String) {
        db.child("user").child(id).child("match_list").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as! NSArray
            value.adding(NSNumber(value: Int(self.user.id)!))
            self.db.child("user").child(id).child("match_list").setValue(value)
        })
        db.child("user").child(id).observeSingleEvent(of: .value, with: { result in
            self.nearby.removeAll { $0.id == id }
            
        })

//        db.child("user").child(id).child("like_list").observeSingleEvent(of: .value, with: { (snapshot) in
//            let value = snapshot.value as! NSArray
//            value.adding(id)
//            self.db.child("user").child(id).child("like_list").setValue(value)
//        })
////        db.child("user").child(id).child("like_list").child(user.id).setValue(1)
//        db.child("user").child(id).observeSingleEvent(of: .value, with: { result in
//            self.nearby.removeAll { $0.id == id }
//        })
    }
}

// fetch list of all snapshots from server
