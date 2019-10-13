//
//  SceneDelegate.swift
//  crush
//
//  Created by Fuhu Xiao on 10/11/19.
//  Copyright © 2019 Crush Inc. All rights reserved.
//

import UIKit
import SwiftUI
import Firebase
import FirebaseDatabase
import CoreLocation

class SceneDelegate: UIResponder, UIWindowSceneDelegate, CLLocationManagerDelegate  {

    var state = AppState()
    var window: UIWindow?
    var foo: UIWindow?
    var ref: DatabaseReference!


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        // Initialize state object
        state.manager.delegate = self
        state.manager.startUpdatingLocation()
        state.manager.desiredAccuracy = kCLLocationAccuracyBest;
        state.getUser(id: "1") { user in
            self.state.user = user
            
            // load data
            let db = Database.database().reference()
            db.child("user").child(self.state.user.id).child("like_list").observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as! NSArray
                for i in value {
                    self.state.getUser(id: String(describing: i)) { user in
                        self.state.liked.append(user)
                    }
                }
            })
            db.child("user").child(self.state.user.id).child("match_list").observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as! NSArray
                for i in value {
                    self.state.getUser(id: String(describing: i)) { user in
                        self.state.matched.append(user)
                    }
                }
            })
            
            
            // Create the SwiftUI view that provides the window contents.
            if let windowScene = scene as? UIWindowScene {
                let window = UIWindow(windowScene: windowScene)
                window.rootViewController = UIHostingController(rootView: MainView(state: self.state))
                self.window = window
                window.makeKeyAndVisible()
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    func locationManager(_ manager: CLLocationManager,
            didUpdateLocations locations: [CLLocation]) {
        state.sendLocation()
    }
}

