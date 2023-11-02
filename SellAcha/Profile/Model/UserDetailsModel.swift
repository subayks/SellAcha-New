//
//  UserDetailsModel.swift
//  SellAcha
//
//  Created by Subaykala on 28/10/23.
//

import Foundation
struct UserDetailsModel: Codable {

  var id                  : Int?    = nil
  var roleId              : Int?    = nil
  var status              : Int?    = nil
  var shopType            : Int?    = nil
  var domainId            : Int?    = nil
  var name                : String? = nil
  var email               : String? = nil
  var emailVerifiedAt     : String? = nil
  var createdBy           : String? = nil
  var createdAt           : String? = nil
  var updatedAt           : String? = nil
  var uType               : String? = nil
  var sertype             : String? = nil
  var mob                 : String? = nil
  var passwordRecovery    : String? = nil
  var documentVerified    : String? = nil
  var emailVerified       : String? = nil
  var emailHash           : String? = nil
  var accountType         : String? = nil
  var accountLevel        : String? = nil
  var accountUser         : String? = nil
  var ip                  : String? = nil
  var lastLogin           : String? = nil
  var signupTime          : String? = nil
  var googlecode          : String? = nil
  var walletPassphrase    : String? = nil
  var firstName           : String? = nil
  var lastName            : String? = nil
  var businessName        : String? = nil
  var businessWebsite     : String? = nil
  var businessCountry     : String? = nil
  var businessDescription : String? = nil
  var businessCategory    : String? = nil
  var businessWhoPayFee   : String? = nil
  var merchantApiKey      : String? = nil
  var businessReject      : String? = nil
  var businessStatus      : String? = nil
  var country             : String? = nil
  var city                : String? = nil
  var province            : String? = nil
  var zipCode             : String? = nil
  var address             : String? = nil
  var birthdayDate        : String? = nil
  var ref1                : String? = nil
  var membership          : String? = nil
  var veri                : String? = nil
  var videoLink           : String? = nil
  var mobile              : String? = nil
  var plnt                : String? = nil
  var ispur               : String? = nil
  var customDomain        : String? = nil
  var nimbusToken         : String? = nil
  var nimbusStatus        : String? = nil

  enum CodingKeys: String, CodingKey {

    case id                  = "id"
    case roleId              = "role_id"
    case status              = "status"
    case shopType            = "shop_type"
    case domainId            = "domain_id"
    case name                = "name"
    case email               = "email"
    case emailVerifiedAt     = "email_verified_at"
    case createdBy           = "created_by"
    case createdAt           = "created_at"
    case updatedAt           = "updated_at"
    case uType               = "u_type"
    case sertype             = "sertype"
    case mob                 = "mob"
    case passwordRecovery    = "password_recovery"
    case documentVerified    = "document_verified"
    case emailVerified       = "email_verified"
    case emailHash           = "email_hash"
    case accountType         = "account_type"
    case accountLevel        = "account_level"
    case accountUser         = "account_user"
    case ip                  = "ip"
    case lastLogin           = "last_login"
    case signupTime          = "signup_time"
    case googlecode          = "googlecode"
    case walletPassphrase    = "wallet_passphrase"
    case firstName           = "first_name"
    case lastName            = "last_name"
    case businessName        = "business_name"
    case businessWebsite     = "business_website"
    case businessCountry     = "business_country"
    case businessDescription = "business_description"
    case businessCategory    = "business_category"
    case businessWhoPayFee   = "business_who_pay_fee"
    case merchantApiKey      = "merchant_api_key"
    case businessReject      = "business_reject"
    case businessStatus      = "business_status"
    case country             = "country"
    case city                = "city"
    case province            = "province"
    case zipCode             = "zip_code"
    case address             = "address"
    case birthdayDate        = "birthday_date"
    case ref1                = "ref1"
    case membership          = "membership"
    case veri                = "veri"
    case videoLink           = "video_link"
    case mobile              = "mobile"
    case plnt                = "plnt"
    case ispur               = "ispur"
    case customDomain        = "custom_domain"
    case nimbusToken         = "nimbus_token"
    case nimbusStatus        = "nimbus_status"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id                  = try values.decodeIfPresent(Int.self    , forKey: .id                  )
    roleId              = try values.decodeIfPresent(Int.self    , forKey: .roleId              )
    status              = try values.decodeIfPresent(Int.self    , forKey: .status              )
    shopType            = try values.decodeIfPresent(Int.self    , forKey: .shopType            )
    domainId            = try values.decodeIfPresent(Int.self    , forKey: .domainId            )
    name                = try values.decodeIfPresent(String.self , forKey: .name                )
    email               = try values.decodeIfPresent(String.self , forKey: .email               )
    emailVerifiedAt     = try values.decodeIfPresent(String.self , forKey: .emailVerifiedAt     )
    createdBy           = try values.decodeIfPresent(String.self , forKey: .createdBy           )
    createdAt           = try values.decodeIfPresent(String.self , forKey: .createdAt           )
    updatedAt           = try values.decodeIfPresent(String.self , forKey: .updatedAt           )
    uType               = try values.decodeIfPresent(String.self , forKey: .uType               )
    sertype             = try values.decodeIfPresent(String.self , forKey: .sertype             )
    mob                 = try values.decodeIfPresent(String.self , forKey: .mob                 )
    passwordRecovery    = try values.decodeIfPresent(String.self , forKey: .passwordRecovery    )
    documentVerified    = try values.decodeIfPresent(String.self , forKey: .documentVerified    )
    emailVerified       = try values.decodeIfPresent(String.self , forKey: .emailVerified       )
    emailHash           = try values.decodeIfPresent(String.self , forKey: .emailHash           )
    accountType         = try values.decodeIfPresent(String.self , forKey: .accountType         )
    accountLevel        = try values.decodeIfPresent(String.self , forKey: .accountLevel        )
    accountUser         = try values.decodeIfPresent(String.self , forKey: .accountUser         )
    ip                  = try values.decodeIfPresent(String.self , forKey: .ip                  )
    lastLogin           = try values.decodeIfPresent(String.self , forKey: .lastLogin           )
    signupTime          = try values.decodeIfPresent(String.self , forKey: .signupTime          )
    googlecode          = try values.decodeIfPresent(String.self , forKey: .googlecode          )
    walletPassphrase    = try values.decodeIfPresent(String.self , forKey: .walletPassphrase    )
    firstName           = try values.decodeIfPresent(String.self , forKey: .firstName           )
    lastName            = try values.decodeIfPresent(String.self , forKey: .lastName            )
    businessName        = try values.decodeIfPresent(String.self , forKey: .businessName        )
    businessWebsite     = try values.decodeIfPresent(String.self , forKey: .businessWebsite     )
    businessCountry     = try values.decodeIfPresent(String.self , forKey: .businessCountry     )
    businessDescription = try values.decodeIfPresent(String.self , forKey: .businessDescription )
    businessCategory    = try values.decodeIfPresent(String.self , forKey: .businessCategory    )
    businessWhoPayFee   = try values.decodeIfPresent(String.self , forKey: .businessWhoPayFee   )
    merchantApiKey      = try values.decodeIfPresent(String.self , forKey: .merchantApiKey      )
    businessReject      = try values.decodeIfPresent(String.self , forKey: .businessReject      )
    businessStatus      = try values.decodeIfPresent(String.self , forKey: .businessStatus      )
    country             = try values.decodeIfPresent(String.self , forKey: .country             )
    city                = try values.decodeIfPresent(String.self , forKey: .city                )
    province            = try values.decodeIfPresent(String.self , forKey: .province            )
    zipCode             = try values.decodeIfPresent(String.self , forKey: .zipCode             )
    address             = try values.decodeIfPresent(String.self , forKey: .address             )
    birthdayDate        = try values.decodeIfPresent(String.self , forKey: .birthdayDate        )
    ref1                = try values.decodeIfPresent(String.self , forKey: .ref1                )
    membership          = try values.decodeIfPresent(String.self , forKey: .membership          )
    veri                = try values.decodeIfPresent(String.self , forKey: .veri                )
    videoLink           = try values.decodeIfPresent(String.self , forKey: .videoLink           )
    mobile              = try values.decodeIfPresent(String.self , forKey: .mobile              )
    plnt                = try values.decodeIfPresent(String.self , forKey: .plnt                )
    ispur               = try values.decodeIfPresent(String.self , forKey: .ispur               )
    customDomain        = try values.decodeIfPresent(String.self , forKey: .customDomain        )
    nimbusToken         = try values.decodeIfPresent(String.self , forKey: .nimbusToken         )
    nimbusStatus        = try values.decodeIfPresent(String.self , forKey: .nimbusStatus        )
 
  }

  init() {

  }

}
