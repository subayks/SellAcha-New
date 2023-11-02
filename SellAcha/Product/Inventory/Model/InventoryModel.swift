//
//  Model.swift
//  SellAcha
//
//  Created by apple on 23/10/23.
//

import Foundation

struct InventoryModel: Codable {

  var posts      : InventoryPost?   = InventoryPost()
 

  enum CodingKeys: String, CodingKey {

    case posts      = "posts"
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    posts      = try values.decodeIfPresent(InventoryPost.self   , forKey: .posts      )
  }

  init() {

  }

}

struct InventoryPost: Codable {

  var currentPage  : Int?     = nil
  var data         : [InventoryData]?  = []
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
    data         = try values.decodeIfPresent([InventoryData].self  , forKey: .data         )
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

struct InventoryData: Codable {
    
    var id          : Int?    = nil
    var termId      : Int?    = nil
    var stockManage : Int?    = nil
    var stockStatus : Int?    = nil
    var stockQty    : Int?    = nil
    var sku         : String? = nil
    var term        : Term?   = Term()

    enum CodingKeys: String, CodingKey {

      case id          = "id"
      case termId      = "term_id"
      case stockManage = "stock_manage"
      case stockStatus = "stock_status"
      case stockQty    = "stock_qty"
      case sku         = "sku"
      case term        = "term"
    
    }

    init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)

      id          = try values.decodeIfPresent(Int.self    , forKey: .id          )
      termId      = try values.decodeIfPresent(Int.self    , forKey: .termId      )
      stockManage = try values.decodeIfPresent(Int.self    , forKey: .stockManage )
      stockStatus = try values.decodeIfPresent(Int.self    , forKey: .stockStatus )
      stockQty    = try values.decodeIfPresent(Int.self    , forKey: .stockQty    )
      sku         = try values.decodeIfPresent(String.self , forKey: .sku         )
      term        = try values.decodeIfPresent(Term.self   , forKey: .term        )
   
    }

    init() {

    }

  }

struct Term: Codable {

  var id              : Int?    = nil
  var title           : String? = nil
  var slug            : String? = nil
  var userId          : Int?    = nil
  var status          : Int?    = nil
  var featured        : Int?    = nil
  var type            : String? = nil
  var isAdmin         : Int?    = nil
  var createdAt       : String? = nil
  var updatedAt       : String? = nil
  var serviceLocation : String? = nil
  var serviceType     : String? = nil
  var youtubeLink     : String? = nil
  var question1       : String? = nil
  var question2       : String? = nil
  var question3       : String? = nil
  var question4       : String? = nil
  var question5       : String? = nil
  var answer1         : String? = nil
  var answer2         : String? = nil
  var answer3         : String? = nil
  var answer4         : String? = nil
  var answer5         : String? = nil
  var preview         : Preview? = nil

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
    case serviceLocation = "service_location"
    case serviceType     = "service_type"
    case youtubeLink     = "youtube_link"
    case question1       = "question1"
    case question2       = "question2"
    case question3       = "question3"
    case question4       = "question4"
    case question5       = "question5"
    case answer1         = "answer1"
    case answer2         = "answer2"
    case answer3         = "answer3"
    case answer4         = "answer4"
    case answer5         = "answer5"
    case preview         = "preview"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id              = try values.decodeIfPresent(Int.self    , forKey: .id              )
    title           = try values.decodeIfPresent(String.self , forKey: .title           )
    slug            = try values.decodeIfPresent(String.self , forKey: .slug            )
    userId          = try values.decodeIfPresent(Int.self    , forKey: .userId          )
    status          = try values.decodeIfPresent(Int.self    , forKey: .status          )
    featured        = try values.decodeIfPresent(Int.self    , forKey: .featured        )
    type            = try values.decodeIfPresent(String.self , forKey: .type            )
    isAdmin         = try values.decodeIfPresent(Int.self    , forKey: .isAdmin         )
    createdAt       = try values.decodeIfPresent(String.self , forKey: .createdAt       )
    updatedAt       = try values.decodeIfPresent(String.self , forKey: .updatedAt       )
    serviceLocation = try values.decodeIfPresent(String.self , forKey: .serviceLocation )
    serviceType     = try values.decodeIfPresent(String.self , forKey: .serviceType     )
    youtubeLink     = try values.decodeIfPresent(String.self , forKey: .youtubeLink     )
    question1       = try values.decodeIfPresent(String.self , forKey: .question1       )
    question2       = try values.decodeIfPresent(String.self , forKey: .question2       )
    question3       = try values.decodeIfPresent(String.self , forKey: .question3       )
    question4       = try values.decodeIfPresent(String.self , forKey: .question4       )
    question5       = try values.decodeIfPresent(String.self , forKey: .question5       )
    answer1         = try values.decodeIfPresent(String.self , forKey: .answer1         )
    answer2         = try values.decodeIfPresent(String.self , forKey: .answer2         )
    answer3         = try values.decodeIfPresent(String.self , forKey: .answer3         )
    answer4         = try values.decodeIfPresent(String.self , forKey: .answer4         )
    answer5         = try values.decodeIfPresent(String.self , forKey: .answer5         )
    preview         = try values.decodeIfPresent(Preview.self , forKey: .preview         )
 
  }

  init() {

  }

}
