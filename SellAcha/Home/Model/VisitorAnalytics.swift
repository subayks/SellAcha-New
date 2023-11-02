//
//  VisitorAnalytics.swift
//  SellAche (iOS)
//
//  Created by Subaykala on 07/10/23.
//


import Foundation

struct VisitorAnalytics: Codable {

  var TotalVisitorsAndPageViews : [String]? = []
  var MostVisitedPages          : [String]? = []
  var Referrers                 : [String]? = []
  var fetchUserTypes            : [String]? = []
  var TopBrowsers               : [String]? = []

  enum CodingKeys: String, CodingKey {

    case TotalVisitorsAndPageViews = "TotalVisitorsAndPageViews"
    case MostVisitedPages          = "MostVisitedPages"
    case Referrers                 = "Referrers"
    case fetchUserTypes            = "fetchUserTypes"
    case TopBrowsers               = "TopBrowsers"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    TotalVisitorsAndPageViews = try values.decodeIfPresent([String].self , forKey: .TotalVisitorsAndPageViews )
    MostVisitedPages          = try values.decodeIfPresent([String].self , forKey: .MostVisitedPages          )
    Referrers                 = try values.decodeIfPresent([String].self , forKey: .Referrers                 )
    fetchUserTypes            = try values.decodeIfPresent([String].self , forKey: .fetchUserTypes            )
    TopBrowsers               = try values.decodeIfPresent([String].self , forKey: .TopBrowsers               )
 
  }

  init() {

  }

}
