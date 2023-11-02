//
//  OrderStaticsModel.swift
//  SellAche (iOS)
//
//  Created by Subaykala on 06/10/23.
//

import Foundation

struct OrderStaticsData: Codable {

  var totalOrders     : String? = nil
  var totalPending    : String? = nil
  var totalCompleted  : String? = nil
  var totalProcessing : String? = nil
  var totalEarnings   : String? = nil

  enum CodingKeys: String, CodingKey {

    case totalOrders     = "total_orders"
    case totalPending    = "total_pending"
    case totalCompleted  = "total_completed"
    case totalProcessing = "total_processing"
    case totalEarnings   = "total_earnings"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    totalOrders     = try values.decodeIfPresent(String.self , forKey: .totalOrders     )
    totalPending    = try values.decodeIfPresent(String.self , forKey: .totalPending    )
    totalCompleted  = try values.decodeIfPresent(String.self , forKey: .totalCompleted  )
    totalProcessing = try values.decodeIfPresent(String.self , forKey: .totalProcessing )
    totalEarnings   = try values.decodeIfPresent(String.self , forKey: .totalEarnings   )
 
  }

  init() {

  }

}

