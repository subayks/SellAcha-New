//
//  TransactionModel.swift
//  SellAcha
//
//  Created by Subaykala on 23/10/23.
//

import Foundation
struct TransactionModel: Codable {
    
    var orders  : Orders?    = Orders()
    // var request : Request?   = Request()
    var getways : [Getways]? = []
    
    enum CodingKeys: String, CodingKey {
        
        case orders  = "orders"
        //  case request = "request"
        case getways = "getways"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        orders  = try values.decodeIfPresent(Orders.self    , forKey: .orders  )
        //   request = try values.decodeIfPresent(Request.self   , forKey: .request )
        getways = try values.decodeIfPresent([Getways].self , forKey: .getways )
        
    }
    
    init() {
        
    }
    
}

struct Getway: Codable {
    
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

struct Customer: Codable {
    
    var id         : Int?    = nil
    var name       : String? = nil
    var email       : String? = nil
    var domainId   : Int?    = nil
    var createdBy : Int?    = nil
    var createdAt  : String? = nil
    var updatedAt  : String? = nil
    var userId     : Int?    = nil
    var ordersCount: Int? = nil
    enum CodingKeys: String, CodingKey {
        
        case id         = "id"
        case name       = "name"
        case email       = "email"
        case domainId   = "domain_id"
        case createdBy = "created_by"
        case createdAt  = "created_at"
        case updatedAt  = "updated_at"
        case userId     = "user_id"
        case ordersCount = "orders_count"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id         = try values.decodeIfPresent(Int.self    , forKey: .id         )
        name       = try values.decodeIfPresent(String.self , forKey: .name       )
        email       = try values.decodeIfPresent(String.self , forKey: .email       )
        domainId   = try values.decodeIfPresent(Int.self    , forKey: .domainId   )
        createdBy = try values.decodeIfPresent(Int.self    , forKey: .createdBy )
        createdAt  = try values.decodeIfPresent(String.self , forKey: .createdAt  )
        updatedAt  = try values.decodeIfPresent(String.self , forKey: .updatedAt  )
        userId     = try values.decodeIfPresent(Int.self    , forKey: .userId     )
        ordersCount = try values.decodeIfPresent(Int.self    , forKey: .ordersCount     )
    }
    
    init() {
        
    }
    
}

struct Getways: Codable {
    
    var id         : Int?    = nil
    var userId     : Int?    = nil
    var categoryId : Int?    = nil
    var content    : String? = nil
    var status     : Int?    = nil
    var createdAt  : String? = nil
    var updatedAt  : String? = nil
    var method     : Method? = Method()
    
    enum CodingKeys: String, CodingKey {
        
        case id         = "id"
        case userId     = "user_id"
        case categoryId = "category_id"
        case content    = "content"
        case status     = "status"
        case createdAt  = "created_at"
        case updatedAt  = "updated_at"
        case method     = "method"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id         = try values.decodeIfPresent(Int.self    , forKey: .id         )
        userId     = try values.decodeIfPresent(Int.self    , forKey: .userId     )
        categoryId = try values.decodeIfPresent(Int.self    , forKey: .categoryId )
        content    = try values.decodeIfPresent(String.self , forKey: .content    )
        status     = try values.decodeIfPresent(Int.self    , forKey: .status     )
        createdAt  = try values.decodeIfPresent(String.self , forKey: .createdAt  )
        updatedAt  = try values.decodeIfPresent(String.self , forKey: .updatedAt  )
        method     = try values.decodeIfPresent(Method.self , forKey: .method     )
        
    }
    
    init() {
        
    }
    
}

struct OrdersData: Codable {
    
    var id         : Int?    = nil
    var orderNo    : String?    = nil
    var transactionId : String?    = nil
    var categoryId    : Int? = nil
    var customerId     : Int?    = nil
    var userId  : Int? = nil
    var orderType  : Int? = nil
    var paymentStatus: Int? = nil
    var status: String? = nil
    var tax: Double? = nil
    var shipping: Int? = nil
    var total: Double? = nil
    var createdAt: String? = nil
    var updatedAt: String? = nil
    var  getway: Getway? = nil
    var orderItemsCount: Int? = nil
    var customer: Customer? = Customer()
    var isSelected:Bool = false

    enum CodingKeys: String, CodingKey {
        
        case id         = "id"
        case orderNo     = "order_no"
        case transactionId = "transaction_id"
        case categoryId    = "category_id"
        case customerId     = "customer_id"
        case userId  = "user_id"
        case orderType  = "order_type"
        case paymentStatus     = "payment_status"
        case status = "status"
        case tax = "tax"
        case shipping = "shipping"
        case total = "total"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case getway = "getway"
        case orderItemsCount = "order_items_count"
        case customer = "customer"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id         = try values.decodeIfPresent(Int.self    , forKey: .id         )
        orderNo     = try values.decodeIfPresent(String.self    , forKey: .orderNo     )
        transactionId = try values.decodeIfPresent(String.self    , forKey: .transactionId )
        categoryId    = try values.decodeIfPresent(Int.self , forKey: .categoryId    )
        customerId     = try values.decodeIfPresent(Int.self    , forKey: .customerId)
        userId  = try values.decodeIfPresent(Int.self , forKey: .userId  )
        orderType  = try values.decodeIfPresent(Int.self , forKey: .orderType  )
        status     = try values.decodeIfPresent(String.self , forKey: .status     )
        tax  = try values.decodeIfPresent(Double.self , forKey: .tax     )
        shipping = try values.decodeIfPresent(Int.self , forKey: .shipping     )
        total = try values.decodeIfPresent(Double.self , forKey: .total     )
        createdAt =  try values.decodeIfPresent(String.self , forKey: .createdAt     )
        getway = try values.decodeIfPresent(Getway.self , forKey: .getway     )
        orderItemsCount = try values.decodeIfPresent(Int.self , forKey: .orderItemsCount     )
        customer = try values.decodeIfPresent(Customer.self , forKey: .customer     )
    }
    
    init() {
        
    }
    
}

//struct Headers: Codable {
//
//
//  enum CodingKeys: String, CodingKey {
//
//
//  }
//
//  init(from decoder: Decoder) throws {
//    let values = try decoder.container(keyedBy: CodingKeys.self)
//
//
//  }
//
//  init() {
//
//  }
//
//}

struct Method: Codable {
    
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

struct Orders: Codable {
    
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

//struct Query: Codable {
//
//
//  enum CodingKeys: String, CodingKey {
//
//
//  }
//
//  init(from decoder: Decoder) throws {
//    let values = try decoder.container(keyedBy: CodingKeys.self)
//
//
//  }
//
//  init() {
//
//  }
//
//}

//struct Request: Codable {
//
//  var attributes : Attributes? = Attributes()
//  var request    : Request?    = Request()
//  var query      : Query?      = Query()
//  var server     : Server?     = Server()
//  var files      : Files?      = Files()
//  var cookies    : Cookies?    = Cookies()
//  var headers    : Headers?    = Headers()
//
//  enum CodingKeys: String, CodingKey {
//
//    case attributes = "attributes"
//    case request    = "request"
//    case query      = "query"
//    case server     = "server"
//    case files      = "files"
//    case cookies    = "cookies"
//    case headers    = "headers"
//
//  }
//
//  init(from decoder: Decoder) throws {
//    let values = try decoder.container(keyedBy: CodingKeys.self)
//
//    attributes = try values.decodeIfPresent(Attributes.self , forKey: .attributes )
//    request    = try values.decodeIfPresent(Request.self    , forKey: .request    )
//    query      = try values.decodeIfPresent(Query.self      , forKey: .query      )
//    server     = try values.decodeIfPresent(Server.self     , forKey: .server     )
//    files      = try values.decodeIfPresent(Files.self      , forKey: .files      )
//    cookies    = try values.decodeIfPresent(Cookies.self    , forKey: .cookies    )
//    headers    = try values.decodeIfPresent(Headers.self    , forKey: .headers    )
//
//  }
//
//  init() {
//
//  }
//
//}

//struct Server: Codable {
//
//
//  enum CodingKeys: String, CodingKey {
//
//
//  }
//
//  init(from decoder: Decoder) throws {
//    let values = try decoder.container(keyedBy: CodingKeys.self)
//
//
//  }
//
//  init() {
//
//  }
//
//}

//struct Attributes: Codable {
//
//
//  enum CodingKeys: String, CodingKey {
//
//
//  }
//
//  init(from decoder: Decoder) throws {
//    let values = try decoder.container(keyedBy: CodingKeys.self)
//
//
//  }
//
//  init() {
//
//  }
//
//}

//struct Cookies: Codable {
//
//
//  enum CodingKeys: String, CodingKey {
//
//
//  }
//
//  init(from decoder: Decoder) throws {
//    let values = try decoder.container(keyedBy: CodingKeys.self)
//
//
//  }
//
//  init() {
//
//  }
//
//}

//struct Files: Codable {
//
//
//  enum CodingKeys: String, CodingKey {
//
//
//  }
//
//  init(from decoder: Decoder) throws {
//    let values = try decoder.container(keyedBy: CodingKeys.self)
//
//
//  }
//
//  init() {
//
//  }
//
//}
