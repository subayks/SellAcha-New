//
//  StaticDataModel.swift
//  SellAche (iOS)
//
//  Created by Subaykala on 06/10/23.
//

import Foundation

struct StaticData: Codable {

  var totalEarnings       : String?     = nil
  var totalSales          : String?     = nil
  var storageSize         : String?     = nil
  var todaySaleAmount     : String?     = nil
  var todayOrders         : String?     = nil
  var yesterdaySaleAmount : String?     = nil
  var lastweekSaleAmount  : String?     = nil
  var lastmonthSaleAmount : String?     = nil
  var thismonthSaleAmount : String?     = nil
  var orders              : [StaticOrders]?   = []
  var earnings            : [Earnings]? = []
  var products            : Int?        = nil
  var pages               : Int?        = nil
  var storageUsed         : Double?     = nil
  var planName            : String?     = nil
  var productLimit        : String?     = nil
  var storage             : String?     = nil
  var willExpired         : String?     = nil

  enum CodingKeys: String, CodingKey {

    case totalEarnings       = "totalEarnings"
    case totalSales          = "totalSales"
    case storageSize         = "storage_size"
    case todaySaleAmount     = "today_sale_amount"
    case todayOrders         = "today_orders"
    case yesterdaySaleAmount = "yesterday_sale_amount"
    case lastweekSaleAmount  = "lastweek_sale_amount"
    case lastmonthSaleAmount = "lastmonth_sale_amount"
    case thismonthSaleAmount = "thismonth_sale_amount"
    case orders              = "orders"
    case earnings            = "earnings"
    case products            = "products"
    case pages               = "pages"
    case storageUsed         = "storage_used"
    case planName            = "plan_name"
    case productLimit        = "product_limit"
    case storage             = "storage"
    case willExpired         = "will_expired"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    totalEarnings       = try values.decodeIfPresent(String.self     , forKey: .totalEarnings       )
    totalSales          = try values.decodeIfPresent(String.self     , forKey: .totalSales          )
    storageSize         = try values.decodeIfPresent(String.self     , forKey: .storageSize         )
    todaySaleAmount     = try values.decodeIfPresent(String.self     , forKey: .todaySaleAmount     )
    todayOrders         = try values.decodeIfPresent(String.self     , forKey: .todayOrders         )
    yesterdaySaleAmount = try values.decodeIfPresent(String.self     , forKey: .yesterdaySaleAmount )
    lastweekSaleAmount  = try values.decodeIfPresent(String.self     , forKey: .lastweekSaleAmount  )
    lastmonthSaleAmount = try values.decodeIfPresent(String.self     , forKey: .lastmonthSaleAmount )
    thismonthSaleAmount = try values.decodeIfPresent(String.self     , forKey: .thismonthSaleAmount )
    orders              = try values.decodeIfPresent([StaticOrders].self   , forKey: .orders              )
    earnings            = try values.decodeIfPresent([Earnings].self , forKey: .earnings            )
    products            = try values.decodeIfPresent(Int.self        , forKey: .products            )
    pages               = try values.decodeIfPresent(Int.self        , forKey: .pages               )
    storageUsed         = try values.decodeIfPresent(Double.self     , forKey: .storageUsed         )
    planName            = try values.decodeIfPresent(String.self     , forKey: .planName            )
    productLimit        = try values.decodeIfPresent(String.self     , forKey: .productLimit        )
    storage             = try values.decodeIfPresent(String.self     , forKey: .storage             )
    willExpired         = try values.decodeIfPresent(String.self     , forKey: .willExpired         )
 
  }

  init() {

  }

}

struct Earnings: Codable {

  var year  : Int?    = nil
  var month : String? = nil
  var total : Double?    = nil

  enum CodingKeys: String, CodingKey {

    case year  = "year"
    case month = "month"
    case total = "total"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    year  = try values.decodeIfPresent(Int.self    , forKey: .year  )
    month = try values.decodeIfPresent(String.self , forKey: .month )
    total = try values.decodeIfPresent(Double.self    , forKey: .total )
 
  }

  init() {

  }

}


import Foundation

struct StaticOrders: Codable {

  var year  : Int?    = nil
  var month : String? = nil
  var sales : Int?    = nil

  enum CodingKeys: String, CodingKey {

    case year  = "year"
    case month = "month"
    case sales = "sales"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    year  = try values.decodeIfPresent(Int.self    , forKey: .year  )
    month = try values.decodeIfPresent(String.self , forKey: .month )
    sales = try values.decodeIfPresent(Int.self    , forKey: .sales )
 
  }

  init() {

  }

}

