//
//  ProductsModel.swift
//  SellAcha
//
//  Created by Subaykala on 24/10/23.
//

import Foundation
struct ProductsModel: Codable {

  var posts      : ProductsPosts?   = ProductsPosts()
  var src        : String?  = nil
  var type       : Int?     = nil
  var actives    : Int?     = nil
  var drafts     : Int?     = nil
  var incomplete : Int?     = nil
  var trash      : Int?     = nil
 // var request    : Request? = Request()

  enum CodingKeys: String, CodingKey {

    case posts      = "posts"
    case src        = "src"
    case type       = "type"
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
    type       = try values.decodeIfPresent(Int.self     , forKey: .type       )
    actives    = try values.decodeIfPresent(Int.self     , forKey: .actives    )
    drafts     = try values.decodeIfPresent(Int.self     , forKey: .drafts     )
    incomplete = try values.decodeIfPresent(Int.self     , forKey: .incomplete )
    trash      = try values.decodeIfPresent(Int.self     , forKey: .trash      )
  //  request    = try values.decodeIfPresent(Request.self , forKey: .request    )
 
  }

  init() {

  }

}

struct ProductsPosts: Codable {

  var currentPage  : Int?     = nil
  var data         : [ProductsData]?  = []
  var firstPageUrl : String?  = nil
  var from         : Int?     = nil
  var lastPage     : Int?     = nil
  var lastPageUrl  : String?  = nil
 // var links        : [Links]? = []
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
   // case links        = "links"
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
    data         = try values.decodeIfPresent([ProductsData].self  , forKey: .data         )
    firstPageUrl = try values.decodeIfPresent(String.self  , forKey: .firstPageUrl )
    from         = try values.decodeIfPresent(Int.self     , forKey: .from         )
    lastPage     = try values.decodeIfPresent(Int.self     , forKey: .lastPage     )
    lastPageUrl  = try values.decodeIfPresent(String.self  , forKey: .lastPageUrl  )
  //  links        = try values.decodeIfPresent([Links].self , forKey: .links        )
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

struct ProductsData: Codable {

  var id              : Int?     = nil
  var title           : String?  = nil
  var slug            : String?  = nil
  var userId          : Int?     = nil
  var status          : Int?     = nil
  var featured        : Int?     = nil
  var type            : String?  = nil
  var isAdmin         : Int?     = nil
  var createdAt       : String?  = nil
  var updatedAt       : String?  = nil
  var formateDate     : String?  = nil
  var orderCount      : Int?     = nil
  var preview         : Preview? = Preview()
  var price           : Price?   = Price()
  var isSelected:Bool = false

  enum CodingKeys: String, CodingKey {

    case id              = "id"
    case title           = "title"
    case slug            = "slug"
    case userId          = "user_id"
    case status          = "status"
    case featured        = "featured"
    case type            = "type"
    case isAdmin         = "is_admin"
    case createdAt       = "created_at"
    case updatedAt       = "updated_at"
    case formateDate     = "formate_date"
    case orderCount      = "order_count"
    case preview         = "preview"
    case price           = "price"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id              = try values.decodeIfPresent(Int.self     , forKey: .id              )
    title           = try values.decodeIfPresent(String.self  , forKey: .title           )
    slug            = try values.decodeIfPresent(String.self  , forKey: .slug            )
    userId          = try values.decodeIfPresent(Int.self     , forKey: .userId          )
    status          = try values.decodeIfPresent(Int.self     , forKey: .status          )
    featured        = try values.decodeIfPresent(Int.self     , forKey: .featured        )
    type            = try values.decodeIfPresent(String.self  , forKey: .type            )
    isAdmin         = try values.decodeIfPresent(Int.self     , forKey: .isAdmin         )
    createdAt       = try values.decodeIfPresent(String.self  , forKey: .createdAt       )
    updatedAt       = try values.decodeIfPresent(String.self  , forKey: .updatedAt       )
    formateDate     = try values.decodeIfPresent(String.self  , forKey: .formateDate     )
    orderCount      = try values.decodeIfPresent(Int.self     , forKey: .orderCount      )
    preview         = try values.decodeIfPresent(Preview.self , forKey: .preview         )
    price           = try values.decodeIfPresent(Price.self   , forKey: .price           )
 
  }

  init() {

  }

}

struct Preview: Codable {

  var mediaId : Int?   = nil
  var termId  : Int?   = nil
  var media   : Media? = Media()
  var content: String? = nil
    
  enum CodingKeys: String, CodingKey {

    case mediaId = "media_id"
    case termId  = "term_id"
    case media   = "media"
      case content = "content"
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    mediaId = try values.decodeIfPresent(Int.self   , forKey: .mediaId )
    termId  = try values.decodeIfPresent(Int.self   , forKey: .termId  )
    media   = try values.decodeIfPresent(Media.self , forKey: .media   )
      content = try values.decodeIfPresent(String.self , forKey: .content   )
  }

  init() {

  }

}

struct Price: Codable {

  var id           : Int?    = nil
  var termId       : Int?    = nil
  var price        : Int?    = nil
  var regularPrice : Int?    = nil
  var specialPrice : Int? = nil
  var priceType    : Int?    = nil
  var startingDate : String? = nil
  var endingDate   : String? = nil

  enum CodingKeys: String, CodingKey {

    case id           = "id"
    case termId       = "term_id"
    case price        = "price"
    case regularPrice = "regular_price"
    case specialPrice = "special_prices"
    case priceType    = "price_type"
    case startingDate = "starting_date"
    case endingDate   = "ending_date"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id           = try values.decodeIfPresent(Int.self    , forKey: .id           )
    termId       = try values.decodeIfPresent(Int.self    , forKey: .termId       )
    price        = try values.decodeIfPresent(Int.self    , forKey: .price        )
    regularPrice = try values.decodeIfPresent(Int.self    , forKey: .regularPrice )
    specialPrice = try values.decodeIfPresent(Int.self , forKey: .specialPrice )
    priceType    = try values.decodeIfPresent(Int.self    , forKey: .priceType    )
    startingDate = try values.decodeIfPresent(String.self , forKey: .startingDate )
    endingDate   = try values.decodeIfPresent(String.self , forKey: .endingDate   )
 
  }

  init() {

  }

}

struct Media: Codable {

  var id  : Int?    = nil
  var url : String? = nil

  enum CodingKeys: String, CodingKey {

    case id  = "id"
    case url = "url"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id  = try values.decodeIfPresent(Int.self    , forKey: .id  )
    url = try values.decodeIfPresent(String.self , forKey: .url )
 
  }

  init() {

  }

}

