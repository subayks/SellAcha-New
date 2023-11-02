//
//  PerformanceData.swift
//  SellAche (iOS)
//
//  Created by Subaykala on 06/10/23.
//

import Foundation

struct PerformanceData: Codable {

    let success : Bool
    let data : [PerformanceDataItems]?

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case data = "data"
    }
}

struct PerformanceDataItems: Codable {

  var year  : Int?    = nil
  var date  : String? = nil
  var total : Double?    = nil

  enum CodingKeys: String, CodingKey {

    case year  = "year"
    case date  = "date"
    case total = "total"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    year  = try values.decodeIfPresent(Int.self    , forKey: .year  )
    date  = try values.decodeIfPresent(String.self , forKey: .date  )
    total = try values.decodeIfPresent(Double.self    , forKey: .total )
  }

  init() {

  }

}

