//
//  UserCodeable.swift
//  ListContacts
//
//  Created by Shankar on 01/02/20.
//  Copyright © 2020 Shankar. All rights reserved.
//

import Foundation

struct UserCodeable: Codable {
    var name: String?
    var number: String?
    var email: String?
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case number = "number"
        case email = "email"
    }
}
struct User: Codable {
    var user: [UserCodeable]
    
    enum CodingKeys: String, CodingKey {
        case user = "user"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        user = try values.decode([UserCodeable].self, forKey: .user)
    }
}
