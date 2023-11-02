//
//  CustomerVM.swift
//  SellAcha
//
//  Created by Subaykala on 22/10/23.
//

import Foundation
class CustomerVM: BaseViewModel {
    var apiServices: CustomerServicesProtocol?
    var model: CreateCustomerModel?
    var customerModel: Customer?

    init(apiServices: CustomerServicesProtocol = CustomerServices()) {
        self.apiServices = apiServices
    }
        
    init(model: Customer, apiServices: CustomerServicesProtocol = CustomerServices()) {
        self.customerModel = model
        self.apiServices = apiServices
    }
    
    func postCustomer(email: String, name: String, password: String) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            let param = self.getCustomerParam(email: email, name: name, password: password)
            self.apiServices?.postCustomer(finalURL: "\(Constants.Common.finalURL)/api/customer", httpHeaders: [String:String](), withParameters: param, completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                
                DispatchQueue.main.async {
                    if status == true {
                        self.model = result as? CreateCustomerModel
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
    
    func editCustomer(email: String, name: String, password: String) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            let param = self.getEditCustomerParam(email: email, name: name, password: password)
            self.apiServices?.editCustomer(finalURL: "\(Constants.Common.finalURL)/api/edit_customer", httpHeaders: [String:String](), withParameters: param, completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                self.model = nil
                DispatchQueue.main.async {
                    if status == true {
                        self.model = result as? CreateCustomerModel
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
    
    func getCustomerParam(email: String, name: String, password: String) ->String {
    let jsonToReturn: NSDictionary = ["email": "\(email)",
                                      "name": "\(name)", "password": "\(password)"
    ]
    return self.convertDictionaryToJsonString(dict: jsonToReturn)!
    }
    
    func getEditCustomerParam(email: String, name: String, password: String) ->String {
    let jsonToReturn: NSDictionary = ["email": "\(email)",
                                      "name": "\(name)", "password": "\(password)", "change_password": "yes", "ids": "\(self.customerModel?.id ?? 0)"
    ]
    return self.convertDictionaryToJsonString(dict: jsonToReturn)!
    }
}
