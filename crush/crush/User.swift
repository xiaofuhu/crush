//
//  Database.swift
//  crush
//
//  Created by Alexander Zhang on 10/12/19.
//  Copyright © 2019 Crush Inc. All rights reserved.
//

import Foundation

struct User: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var description: String
    var image: String
}
