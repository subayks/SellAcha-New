//
//  ResetPasswordVM.swift
//  SellAcha
//
//  Created by Subaykala on 28/10/23.
//

import Foundation
class ResetPasswordVM: BaseViewModel {
    var apiServices: ProfileServicesProtocol?
    var model: CreateCustomerModel?
    
    init(apiServices: ProfileServicesProtocol = ProfileServices()) {
        self.apiServices = apiServices
    }
    
    func resetPassword(email: String) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            let param = self.getCustomerParam(email: email)

            self.apiServices?.resetPassword(finalURL: "\(Constants.Common.finalURL)/api/user/password/reset", httpHeaders: [String:String](), withParameters: param, completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                
                DispatchQueue.main.async {
                    if status == true {
                        self.model = result as? CreateCustomerModel
                        self.navigationClosure?()
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
    
    func getCustomerParam(email: String) ->String {
        let jsonToReturn: NSDictionary = ["email": "\(email)"]
    return self.convertDictionaryToJsonString(dict: jsonToReturn)!
    }
}
