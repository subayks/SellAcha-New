//
//  CreateShowModel.swift
//  SellAcha
//
//  Created by Subaykala on 07/11/23.
//

import Foundation
struct CreateShowModel: Codable {
    
    var posts      : ProductsPosts?   = ProductsPosts()
    var src        : String?  = nil
    // var type       : Int?     = nil
    var actives    : Int?     = nil
    var drafts     : Int?     = nil
    var incomplete : Int?     = nil
    var trash      : Int?     = nil
    // var request    : Request? = Request()
    
    enum CodingKeys: String, CodingKey {
        
        case posts      = "posts"
        case src        = "src"
        //    case type       = "type"
        case actives    = "actives"
        case drafts     = "drafts"
        case incomplete = "incomplete"
        case trash      = "trash"
        //  case request    = "request"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        posts      = try values.decodeIfPresent(ProductsPosts.self   , forKey: .posts      )
        src        = try values.decodeIfPresent(String.self  , forKey: .src        )
        //  type       = try values.decodeIfPresent(Int.self     , forKey: .type       )
        actives    = try values.decodeIfPresent(Int.self     , forKey: .actives    )
        drafts     = try values.decodeIfPresent(Int.self     , forKey: .drafts     )
        incomplete = try values.decodeIfPresent(Int.self     , forKey: .incomplete )
        trash      = try values.decodeIfPresent(Int.self     , forKey: .trash      )
        //  request    = try values.decodeIfPresent(Request.self , forKey: .request    )
        
    }
    
    init() {
        
    }
    
}
