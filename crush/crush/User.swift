//  User.swift
//  crush
//
//  Created by Fuhu Xiao on 10/12/19.
//  Copyright © 2019 Crush Inc. All rights reserved.
//

import Foundation
import UIKit

struct User: Hashable, Codable, Identifiable {
    var id: String
    var name: String
    var description: String
    var imageUrl: String
}

extension User {
    var image: UIImage {
        let url = URL(string: imageUrl)
        let data = try! Data(contentsOf: url!)
        return UIImage(data: data)!
    }
}
