//
//  User.swift
//  CaploitteNews
//
//  Created by Asanka Gankewala on 11/22/23.
//

import Foundation

public struct User: Codable {
    
    let userName: String
    let email: String?
    let phoneNumber: String?
    let password: String?
    
    enum CodingKeys: String, CodingKey {
        case userName
        case email
        case phoneNumber
        case password
    }
}
