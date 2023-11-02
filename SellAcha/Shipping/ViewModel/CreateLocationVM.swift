//
//  CreateLocationVM.swift
//  SellAcha
//
//  Created by Subaykala on 25/10/23.
//

import Foundation
class CreateLocationVM: BaseViewModel {
    var apiServices: ShippingServiceProtocol?
    var model: LocationData?
    var successModel: CreateCustomerModel?
    var status = ["Active", "Inactive"]
    
    init(apiServices: ShippingServiceProtocol = ShippingService()) {
        self.apiServices = apiServices
    }
    
    init(model: LocationData, apiServices: ShippingServiceProtocol = ShippingService()) {
        self.model = model
        self.apiServices = apiServices
    }
    
    func createLocation(title: String) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            let param = self.getCustomerParam(title: title)
            self.apiServices?.createLocation(finalURL: "\(Constants.Common.finalURL)/api/create_location", httpHeaders: [String:String](), withParameters: param, completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                
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
    
    func editLocation(title: String) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            let param = self.getEditCustomerParam(title: title)
            self.apiServices?.editLocation(finalURL: "\(Constants.Common.finalURL)/edit_location", httpHeaders: [String:String](), withParameters: param, completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
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
    
    func getCustomerParam(title: String) ->String {
    let jsonToReturn: NSDictionary = ["title": "\(title)"
    ]
    return self.convertDictionaryToJsonString(dict: jsonToReturn)!
    }
    
    func getEditCustomerParam(title: String) ->String {
    let jsonToReturn: NSDictionary = ["title": "\(title)",
                                      "id": "\(self.model?.id ?? 0)"
    ]
    return self.convertDictionaryToJsonString(dict: jsonToReturn)!
    }
}
