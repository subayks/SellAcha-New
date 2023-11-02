//
//  CreateCustomerModel.swift
//  SellAcha
//
//  Created by Subaykala on 22/10/23.
//

import Foundation
struct CreateCustomerModel: Codable {

    let success : Bool
    let data : String?

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case data = "data"
    }
}
