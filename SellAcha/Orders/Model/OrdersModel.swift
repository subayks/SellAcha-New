//
//  OrdersModel.swift
//  SellAcha
//
//  Created by Subaykala on 23/10/23.
//

import Foundation
struct OrdersModel: Codable {

  var orders     : Orders?  = Orders()
  var pendings   : Int?     = nil
  var processing : Int?     = nil
  var pickup     : Int?     = nil
  var completed  : Int?     = nil
  var archived   : Int?     = nil
  var canceled   : Int?     = nil
//  var request    : Request? = Request()
  var type       : String?  = nil

  enum CodingKeys: String, CodingKey {

    case orders     = "orders"
    case pendings   = "pendings"
    case processing = "processing"
    case pickup     = "pickup"
    case completed  = "completed"
    case archived   = "archived"
    case canceled   = "canceled"
//    case request    = "request"
    case type       = "type"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    orders     = try values.decodeIfPresent(Orders.self  , forKey: .orders     )
    pendings   = try values.decodeIfPresent(Int.self     , forKey: .pendings   )
    processing = try values.decodeIfPresent(Int.self     , forKey: .processing )
    pickup     = try values.decodeIfPresent(Int.self     , forKey: .pickup     )
    completed  = try values.decodeIfPresent(Int.self     , forKey: .completed  )
    archived   = try values.decodeIfPresent(Int.self     , forKey: .archived   )
    canceled   = try values.decodeIfPresent(Int.self     , forKey: .canceled   )
   // request    = try values.decodeIfPresent(Request.self , forKey: .request    )
    type       = try values.decodeIfPresent(String.self  , forKey: .type       )
 
  }

  init() {

  }

}
