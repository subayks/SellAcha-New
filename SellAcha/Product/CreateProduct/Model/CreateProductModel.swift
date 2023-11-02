//
//  CreateProductModel.swift
//  SellAcha
//
//  Created by apple on 29/10/23.
//

import Foundation

struct createProductModel: Codable{
    var product_id  : Int? = nil
    
    enum CodingKeys: String, CodingKey {

        case product_id = "product_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        product_id = try values.decodeIfPresent(Int.self, forKey: .product_id)
    }
    
    init() {

    }
}
