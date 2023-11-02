//
//  CreateShippingVM.swift
//  SellAcha
//
//  Created by Subaykala on 25/10/23.
//

import Foundation
class CreateShippingVM: BaseViewModel {
    var apiServices: ShippingServiceProtocol?
    var model: ShippingData?
    var successModel: CreateCustomerModel?
    
    init(apiServices: ShippingServiceProtocol = ShippingService()) {
        self.apiServices = apiServices
    }
    
    init(model: ShippingData, apiServices: ShippingServiceProtocol = ShippingService()) {
        self.model = model
        self.apiServices = apiServices
    }
    
    func createLocation(title: String, price: String, location: [Int]) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            let param = self.getCustomerParam(title: title, price: price, location: location)
            self.apiServices?.createShipping(finalURL: "\(Constants.Common.finalURL)/api/create_shipping", httpHeaders: [String:String](), withParameters: param, completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                
                DispatchQueue.main.async {
                    if status == true {
                   //     self.successModel = result as? CreateCustomerModel
                        self.updateView?()
                    }
                    else{
                        self.alertClosure?(errorMessage ?? "Some Technical Problem")
                    }
                }
            })
        }
        else {
            self.alertClosure?("No Internet Availabe")
        }
    }
    
    func editShipping(title: String, price: String, location: [Int]) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            let param = self.getEditCustomerParam(title: title, price: price, location: location)
            self.apiServices?.editShipping(finalURL: "\(Constants.Common.finalURL)/api/edit_shipping", httpHeaders: [String:String](), withParameters: param, completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                self.model = nil
                DispatchQueue.main.async {
                    if status == true {
                        self.successModel = result as? CreateCustomerModel
                        self.updateView?()
                    }
                    else{
                        self.alertClosure?(errorMessage ?? "Some Technical Problem")
                    }
                }
            })
        }
        else {
            self.alertClosure?("No Internet Availabe")
        }
    }
    
    func getCustomerParam(title: String, price: String, location: [Int]) ->String {
        let jsonToReturn: NSDictionary = ["title": "\(title)", "price": "\(price)", "location": "\(location[0])"
    ]
    return self.convertDictionaryToJsonString(dict: jsonToReturn)!
    }
    
    func getEditCustomerParam(title: String, price: String, location: [Int]) ->String {
    let jsonToReturn: NSDictionary = ["title": "\(title)", "price": "\(price)", "location": "\(location[0])", "id": "\(self.model?.id ?? 0)"
    ]
    return self.convertDictionaryToJsonString(dict: jsonToReturn)!
    }
}
