//
//  SubscriptionModel.swift
//  SellAcha
//
//  Created by Subaykala on 07/11/23.
//

import Foundation
struct SubscriptionModel:  Codable {
    
    var id            : Int?      = nil
    var orderNo       : String?   = nil
    var amount        : Double?   = nil
    var tax           : Double?   = nil
    var trx           : String?   = nil
    var willExpire    : String?   = nil
    var userId        : Int?      = nil
    var planId        : Int?      = nil
    var categoryId    : Int?      = nil
    var status        : Int?      = nil
    var paymentStatus : Int?      = nil
    var createdAt     : String?   = nil
    var updatedAt     : String?   = nil
    var plan          : Plan?     = Plan()
    var category      : Category? = Category()

    enum CodingKeys: String, CodingKey {

      case id            = "id"
      case orderNo       = "order_no"
      case amount        = "amount"
      case tax           = "tax"
      case trx           = "trx"
      case willExpire    = "will_expire"
      case userId        = "user_id"
      case planId        = "plan_id"
      case categoryId    = "category_id"
      case status        = "status"
      case paymentStatus = "payment_status"
      case createdAt     = "created_at"
      case updatedAt     = "updated_at"
      case plan          = "plan"
      case category      = "category"
    
    }

    init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)

      id            = try values.decodeIfPresent(Int.self      , forKey: .id            )
      orderNo       = try values.decodeIfPresent(String.self   , forKey: .orderNo       )
      amount        = try values.decodeIfPresent(Double.self   , forKey: .amount        )
      tax           = try values.decodeIfPresent(Double.self   , forKey: .tax           )
      trx           = try values.decodeIfPresent(String.self   , forKey: .trx           )
      willExpire    = try values.decodeIfPresent(String.self   , forKey: .willExpire    )
      userId        = try values.decodeIfPresent(Int.self      , forKey: .userId        )
      planId        = try values.decodeIfPresent(Int.self      , forKey: .planId        )
      categoryId    = try values.decodeIfPresent(Int.self      , forKey: .categoryId    )
      status        = try values.decodeIfPresent(Int.self      , forKey: .status        )
      paymentStatus = try values.decodeIfPresent(Int.self      , forKey: .paymentStatus )
      createdAt     = try values.decodeIfPresent(String.self   , forKey: .createdAt     )
      updatedAt     = try values.decodeIfPresent(String.self   , forKey: .updatedAt     )
      plan          = try values.decodeIfPresent(Plan.self     , forKey: .plan          )
      category      = try values.decodeIfPresent(Category.self , forKey: .category      )
   
    }

    init() {

    }

  }

struct Category: Codable {

  var id         : Int?    = nil
  var name       : String? = nil
  var slug       : String? = nil
  var type       : String? = nil
  var pId        : String? = nil
  var featured   : Int?    = nil
  var menuStatus : Int?    = nil
  var isAdmin    : Int?    = nil
  var createdAt  : String? = nil
  var updatedAt  : String? = nil
  var userId     : Int?    = nil

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
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id         = try values.decodeIfPresent(Int.self    , forKey: .id         )
    name       = try values.decodeIfPresent(String.self , forKey: .name       )
    slug       = try values.decodeIfPresent(String.self , forKey: .slug       )
    type       = try values.decodeIfPresent(String.self , forKey: .type       )
    pId        = try values.decodeIfPresent(String.self , forKey: .pId        )
    featured   = try values.decodeIfPresent(Int.self    , forKey: .featured   )
    menuStatus = try values.decodeIfPresent(Int.self    , forKey: .menuStatus )
    isAdmin    = try values.decodeIfPresent(Int.self    , forKey: .isAdmin    )
    createdAt  = try values.decodeIfPresent(String.self , forKey: .createdAt  )
    updatedAt  = try values.decodeIfPresent(String.self , forKey: .updatedAt  )
    userId     = try values.decodeIfPresent(Int.self    , forKey: .userId     )
 
  }

  init() {

  }

}

struct Plan: Codable {

  var id           : Int?    = nil
  var name         : String? = nil
  var description  : String? = nil
  var price        : Int?    = nil
  var days         : Int?    = nil
  var data         : String? = nil
  var status       : Int?    = nil
  var customDomain : Int?    = nil
  var featured     : Int?    = nil
  var isDefault    : Int?    = nil
  var isTrial      : Int?    = nil
  var createdAt    : String? = nil
  var updatedAt    : String? = nil

  enum CodingKeys: String, CodingKey {

    case id           = "id"
    case name         = "name"
    case description  = "description"
    case price        = "price"
    case days         = "days"
    case data         = "data"
    case status       = "status"
    case customDomain = "custom_domain"
    case featured     = "featured"
    case isDefault    = "is_default"
    case isTrial      = "is_trial"
    case createdAt    = "created_at"
    case updatedAt    = "updated_at"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id           = try values.decodeIfPresent(Int.self    , forKey: .id           )
    name         = try values.decodeIfPresent(String.self , forKey: .name         )
    description  = try values.decodeIfPresent(String.self , forKey: .description  )
    price        = try values.decodeIfPresent(Int.self    , forKey: .price        )
    days         = try values.decodeIfPresent(Int.self    , forKey: .days         )
    data         = try values.decodeIfPresent(String.self , forKey: .data         )
    status       = try values.decodeIfPresent(Int.self    , forKey: .status       )
    customDomain = try values.decodeIfPresent(Int.self    , forKey: .customDomain )
    featured     = try values.decodeIfPresent(Int.self    , forKey: .featured     )
    isDefault    = try values.decodeIfPresent(Int.self    , forKey: .isDefault    )
    isTrial      = try values.decodeIfPresent(Int.self    , forKey: .isTrial      )
    createdAt    = try values.decodeIfPresent(String.self , forKey: .createdAt    )
    updatedAt    = try values.decodeIfPresent(String.self , forKey: .updatedAt    )
 
  }

  init() {

  }

}

