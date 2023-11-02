//
//  LoginModel.swift
//  SellAche
//
//  Created by Tariqul Islam on 1/6/22.
//

import Foundation

struct LoginModel: Codable {
    
    var token : String? = nil
    var name  : String? = nil
    var email : String? = nil

    enum CodingKeys: String, CodingKey {

      case token = "token"
      case name  = "name"
      case email = "email"
    
    }

    init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)

      token = try values.decodeIfPresent(String.self , forKey: .token )
      name  = try values.decodeIfPresent(String.self , forKey: .name  )
      email = try values.decodeIfPresent(String.self , forKey: .email )
   
    }

    init() {

    }

  }
