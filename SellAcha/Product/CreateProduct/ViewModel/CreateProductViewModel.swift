//
//  CreateProductViewModel.swift
//  SellAcha
//
//  Created by apple on 29/10/23.
//

import Foundation
import UIKit

class CreateProductViewModel: BaseViewModel {
    var apiServices: CreateProductApiServiceprotocol?
    var createProductModel: createProductModel?
    var selectedImage: UIImage?
    init(apiServices: CreateProductApiServiceprotocol = CreateProductApiService()) {
        self.apiServices = apiServices
    }
    
    func createProduct(title: String, price: String, specialprice:String, pricetype:String,specialpricestart:String,specialpriceend:String,status:String) {
        let imageRequest = ImageRequestParam(paramName: "media", name: "media", image: self.selectedImage ?? UIImage())
        let otherParam = ["title": "\(title)",
                          "price": "\(price)",
                          "special_price": "\(specialprice)","price_type": "\(pricetype)",
                          "special_price_start": "\(specialpricestart)","special_price_end": "\(specialpriceend)","status":"\(status)"]
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            self.apiServices?.createProduct(finalURL: "\(Constants.Common.finalURL)/api/api/store", withParameters: imageRequest, otherParameters: otherParam, completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                DispatchQueue.main.async {
                    self.hideLoadingIndicatorClosure?()
                    self.updateView?()
                }
            })
        } else {
            self.alertClosure?("Check your internet")
        }
    }
    
    func getProductParamas(title: String, price: String,specialprice:String,pricetype:String,specialpricestart:String,specialpriceend:String,status:String) ->String {
    let jsonToReturn: NSDictionary = ["title": "\(title)",
                                      "price": "\(price)",
                                      "special_price": "\(specialprice)","price_type": "\(pricetype)",
                                      "special_price_start": "\(specialpricestart)","special_price_end": "\(specialpriceend)","status":"\(status)"]
    return self.convertDictionaryToJsonString(dict: jsonToReturn)!
    }
}
