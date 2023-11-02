//
//  BaseResponse.swift
//  SellAche (iOS)
//
//  Created by Subaykala on 06/10/23.
//

import Foundation
struct BaseResponse<T:Codable>: Codable {

    let success : Bool
    let data : T?

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case data = "data"
    }
}

struct BaseResponseArray<T:Codable>: Codable {

    let success : Bool
    let data : [T]?

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case data = "data"
    }
}
