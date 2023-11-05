//
//  CreateAttributeVM.swift
//  SellAcha
//
//  Created by Subaykala on 25/10/23.
//

import Foundation
class CreateAttributeVM: BaseViewModel {
    var apiServices: AttributeServiceProtocol?
    var model: AttributeData?
    var successModel: CreateCustomerModel?
    var status = ["Yes", "No"]
    
    init(apiServices: AttributeServiceProtocol = AttributeService()) {
        self.apiServices = apiServices
    }
    
    init(model: AttributeData, apiServices: AttributeServiceProtocol = AttributeService()) {
        self.model = model
        self.apiServices = apiServices
    }
    
    func createAttributes(name: String, featured: String) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            let param = self.getCustomerParam(name: name, featured: featured)
            self.apiServices?.createAttributes(finalURL: "\(Constants.Common.finalURL)/api/create_attribute", httpHeaders: [String:String](), withParameters: param, completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                
                DispatchQueue.main.async {
                    if status == true {
                    //    self.successModel = result as? CreateCustomerModel
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
    
    func editAttributes(name: String, featured: String) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            let param = self.getEditCustomerParam(name: name, featured: featured)
            self.apiServices?.editAttributes(finalURL: "\(Constants.Common.finalURL)/api/edit_brand", httpHeaders: [String:String](), withParameters: param, completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
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
    
    func getCustomerParam(name: String, featured: String) ->String {
        var status = 0
        if featured == "Yes" {
            status = 1
        } else {
            status = 0
        }
    let jsonToReturn: NSDictionary = ["title": "\(name)",
                                      "featured": "\(status)"
    ]
    return self.convertDictionaryToJsonString(dict: jsonToReturn)!
    }
    
    func getEditCustomerParam(name: String, featured: String) ->String {
        var status = 0
        if featured == "Yes" {
            status = 1
        } else {
            status = 0
        }
    let jsonToReturn: NSDictionary = ["name": "\(name)",
                                      "featured": "\(status)", "id": "\(self.model?.id ?? 0)"
    ]
    return self.convertDictionaryToJsonString(dict: jsonToReturn)!
    }
}
