//
//  Filter.swift
//  CaploitteNews
//
//  Created by Asanka Gankewala on 11/23/23.
//

import Foundation

public struct Filter: Codable {
    
    let name: String?
    var status: Bool?
    
    enum CodingKeys: String, CodingKey {
        case name
        case status
    }
}
