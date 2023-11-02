//
//  CategorieModel.swift
//  SellAcha
//
//  Created by apple on 23/10/23.
//

import Foundation


struct CategorieModel: Codable {
    
    var posts      : BrandsPost?   = BrandsPost()
    
    
    enum CodingKeys: String, CodingKey {
        
        case posts      = "posts"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        posts      = try values.decodeIfPresent(BrandsPost.self   , forKey: .posts      )
    }
    
    init() {
        
    }
    
}
