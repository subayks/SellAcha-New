//
//  ReportsModel.swift
//  SellAcha
//
//  Created by Subaykala on 23/10/23.
//

import Foundation
struct ReportsModel: Codable {

  var orders          : ReportsOrders?  = ReportsOrders()
  var start           : String?  = nil
  var end             : String?  = nil
  var total           : Double?     = nil
  var completed       : Int?     = nil
  var canceled        : Int?     = nil
  var proccess        : Int?     = nil
  var amounts         : Double?     = nil
  var amountCancel    : Double?     = nil
  var amountProccess  : Double?     = nil
  var amountCompleted : Double?     = nil
 // var request         : Request? = Request()

  enum CodingKeys: String, CodingKey {

    case orders          = "orders"
    case start           = "start"
    case end             = "end"
    case total           = "total"
    case completed       = "completed"
    case canceled        = "canceled"
    case proccess        = "proccess"
    case amounts         = "amounts"
    case amountCancel    = "amount_cancel"
    case amountProccess  = "amount_proccess"
    case amountCompleted = "amount_completed"
  //  case request         = "request"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    orders          = try values.decodeIfPresent(ReportsOrders.self  , forKey: .orders          )
    start           = try values.decodeIfPresent(String.self  , forKey: .start           )
    end             = try values.decodeIfPresent(String.self  , forKey: .end             )
    total           = try values.decodeIfPresent(Double.self     , forKey: .total           )
    completed       = try values.decodeIfPresent(Int.self     , forKey: .completed       )
    canceled        = try values.decodeIfPresent(Int.self     , forKey: .canceled        )
    proccess        = try values.decodeIfPresent(Int.self     , forKey: .proccess        )
    amounts         = try values.decodeIfPresent(Double.self     , forKey: .amounts         )
    amountCancel    = try values.decodeIfPresent(Double.self     , forKey: .amountCancel    )
    amountProccess  = try values.decodeIfPresent(Double.self     , forKey: .amountProccess  )
    amountCompleted = try values.decodeIfPresent(Double.self     , forKey: .amountCompleted )
 //   request         = try values.decodeIfPresent(Request.self , forKey: .request         )
 
  }

  init() {

  }

}

struct ReportsOrders: Codable {

  var currentPage  : Int?     = nil
  var data         : [OrdersData]?  = []
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
    data         = try values.decodeIfPresent([OrdersData].self  , forKey: .data         )
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

