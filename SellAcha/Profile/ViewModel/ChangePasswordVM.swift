//
//  ChangePasswordVM.swift
//  SellAcha
//
//  Created by Subaykala on 28/10/23.
//

import Foundation
class ChangePasswordVM: BaseViewModel {
    var apiServices: ProfileServicesProtocol?
    var model: CreateCustomerModel?
    
    init(apiServices: ProfileServicesProtocol = ProfileServices()) {
        self.apiServices = apiServices
    }
    
    func updatePassword(password: String, currentPassword: String) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            let param = self.getCustomerParam(password: password, currentPassword: currentPassword)

            self.apiServices?.updatePassword(finalURL: "\(Constants.Common.finalURL)/api/user_profile_update", httpHeaders: [String:String](), withParameters: param, completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
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
    
    func getCustomerParam(password: String, currentPassword: String) ->String {
        let jsonToReturn: NSDictionary = ["password": "\(password)", "password_current": "\(currentPassword)"]
    return self.convertDictionaryToJsonString(dict: jsonToReturn)!
    }
}
