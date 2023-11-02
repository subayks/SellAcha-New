//
//  LocationModel.swift
//  SellAcha
//
//  Created by Subaykala on 25/10/23.
//

import Foundation
struct LocationModel: Codable {
    
    var posts      : LocationPost?   = LocationPost()
    
    
    enum CodingKeys: String, CodingKey {
        
        case posts      = "posts"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        posts      = try values.decodeIfPresent(LocationPost.self   , forKey: .posts      )
    }
    
    init() {
        
    }
    
}

struct LocationPost: Codable {
    
    var currentPage  : Int?     = nil
    var data         : [LocationData]?  = []
    var firstPageUrl : String?  = nil
    var from         : Int?     = nil
    var lastPage     : Int?     = nil
    var lastPageUrl  : String?  = nil
    var links        : [Links]? = []
    var nextPageUrl  : String?  = nil
    var path         : String?  = nil
    var perPage      : Int?     = nil
    var prevPageUrl  : String?  = nil
    var to           : Int?     = nil
    var total        : Int?     = nil
    
    enum CodingKeys: String, CodingKey {
        
        case currentPage  = "current_page"
        case data         = "data"
        case firstPageUrl = "first_page_url"
        case from         = "from"
        case lastPage     = "last_page"
        case lastPageUrl  = "last_page_url"
        case links        = "links"
        case nextPageUrl  = "next_page_url"
        case path         = "path"
        case perPage      = "per_page"
        case prevPageUrl  = "prev_page_url"
        case to           = "to"
        case total        = "total"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        currentPage  = try values.decodeIfPresent(Int.self     , forKey: .currentPage  )
        data         = try values.decodeIfPresent([LocationData].self  , forKey: .data         )
        firstPageUrl = try values.decodeIfPresent(String.self  , forKey: .firstPageUrl )
        from         = try values.decodeIfPresent(Int.self     , forKey: .from         )
        lastPage     = try values.decodeIfPresent(Int.self     , forKey: .lastPage     )
        lastPageUrl  = try values.decodeIfPresent(String.self  , forKey: .lastPageUrl  )
        links        = try values.decodeIfPresent([Links].self , forKey: .links        )
        nextPageUrl  = try values.decodeIfPresent(String.self  , forKey: .nextPageUrl  )
        path         = try values.decodeIfPresent(String.self  , forKey: .path         )
        perPage      = try values.decodeIfPresent(Int.self     , forKey: .perPage      )
        prevPageUrl  = try values.decodeIfPresent(String.self  , forKey: .prevPageUrl  )
        to           = try values.decodeIfPresent(Int.self     , forKey: .to           )
        total        = try values.decodeIfPresent(Int.self     , forKey: .total        )
        
    }
    
    init() {
        
    }
    
}

struct LocationData: Codable {
    
    var id         : Int?     = nil
    var name       : String?  = nil
    var slug       : String?  = nil
    var type       : String?  = nil
    var pId        : String?  = nil
    var featured   : Int?     = nil
    var menuStatus : Int?     = nil
    var isAdmin    : Int?     = nil
    var createdAt  : String?  = nil
    var updatedAt  : String?  = nil
    var userId     : Int?     = nil
    var preview    : Preview? = Preview()
    
    enum CodingKeys: String, CodingKey {
        
        case id         = "id"
        case name       = "name"
        case slug       = "slug"
        case type       = "type"
        case pId        = "p_id"
        case featured   = "featured"
        case menuStatus = "menu_status"
        case isAdmin    = "is_admin"
        case createdAt  = "created_at"
        case updatedAt  = "updated_at"
        case userId     = "user_id"
        case preview    = "preview"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id         = try values.decodeIfPresent(Int.self     , forKey: .id         )
        name       = try values.decodeIfPresent(String.self  , forKey: .name       )
        slug       = try values.decodeIfPresent(String.self  , forKey: .slug       )
        type       = try values.decodeIfPresent(String.self  , forKey: .type       )
        pId        = try values.decodeIfPresent(String.self  , forKey: .pId        )
        featured   = try values.decodeIfPresent(Int.self     , forKey: .featured   )
        menuStatus = try values.decodeIfPresent(Int.self     , forKey: .menuStatus )
        isAdmin    = try values.decodeIfPresent(Int.self     , forKey: .isAdmin    )
        createdAt  = try values.decodeIfPresent(String.self  , forKey: .createdAt  )
        updatedAt  = try values.decodeIfPresent(String.self  , forKey: .updatedAt  )
        userId     = try values.decodeIfPresent(Int.self     , forKey: .userId     )
        preview    = try values.decodeIfPresent(Preview.self , forKey: .preview    )
        
    }
    
    init() {
        
    }
    
}
