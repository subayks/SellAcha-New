//
//  ReviewModel.swift
//  SellAcha
//
//  Created by Subaykala on 22/10/23.
//

import Foundation

struct ReviewModel: Codable {

  var posts : Posts? = Posts()

  enum CodingKeys: String, CodingKey {

    case posts = "posts"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    posts = try values.decodeIfPresent(Posts.self , forKey: .posts )
 
  }

  init() {

  }

}

struct Links: Codable {

  var url    : String? = nil
  var label  : String? = nil
  var active : Bool?   = nil

  enum CodingKeys: String, CodingKey {

    case url    = "url"
    case label  = "label"
    case active = "active"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    url    = try values.decodeIfPresent(String.self , forKey: .url    )
    label  = try values.decodeIfPresent(String.self , forKey: .label  )
    active = try values.decodeIfPresent(Bool.self   , forKey: .active )
 
  }

  init() {

  }

}

struct Posts: Codable {

  var currentPage  : Int?      = nil
  var data         : [ReviewData]? = []
 

  enum CodingKeys: String, CodingKey {

    case currentPage  = "current_page"
    case data         = "data"
   
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    currentPage  = try values.decodeIfPresent(Int.self      , forKey: .currentPage  )
    data         = try values.decodeIfPresent([ReviewData].self , forKey: .data         )
   
  }

  init() {

  }

}

struct ReviewData: Codable {

  var id        : Int?    = nil
  var userId    : Int?    = nil
  var termId    : Int?    = nil
  var rating    : Int?    = nil
  var name      : String? = nil
  var email     : String? = nil
  var comment   : String? = nil
  var createdAt : String? = nil
  var updatedAt : String? = nil
  var post      : Post?   = Post()

  enum CodingKeys: String, CodingKey {

    case id        = "id"
    case userId    = "user_id"
    case termId    = "term_id"
    case rating    = "rating"
    case name      = "name"
    case email     = "email"
    case comment   = "comment"
    case createdAt = "created_at"
    case updatedAt = "updated_at"
    case post      = "post"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id        = try values.decodeIfPresent(Int.self    , forKey: .id        )
    userId    = try values.decodeIfPresent(Int.self    , forKey: .userId    )
    termId    = try values.decodeIfPresent(Int.self    , forKey: .termId    )
    rating    = try values.decodeIfPresent(Int.self    , forKey: .rating    )
    name      = try values.decodeIfPresent(String.self , forKey: .name      )
    email     = try values.decodeIfPresent(String.self , forKey: .email     )
    comment   = try values.decodeIfPresent(String.self , forKey: .comment   )
    createdAt = try values.decodeIfPresent(String.self , forKey: .createdAt )
    updatedAt = try values.decodeIfPresent(String.self , forKey: .updatedAt )
    post      = try values.decodeIfPresent(Post.self   , forKey: .post      )
 
  }

  init() {

  }

}

struct Post: Codable {

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
 
  }

  init() {

  }

}


