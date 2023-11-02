//
//  ProfileModel.swift
//  SellAcha
//
//  Created by Subaykala on 02/11/23.
//

import Foundation
struct ProfileModel: Codable {
    
    var logo : String?    = nil
    
    enum CodingKeys: String, CodingKey {
        case logo = "logo"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        logo = try values.decodeIfPresent(String.self, forKey: .logo)
    }
    init() {}
}

