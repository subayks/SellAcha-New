//
//  UserDetailsVM.swift
//  SellAcha
//
//  Created by Subaykala on 28/10/23.
//

import Foundation
class UserDetailsVM: BaseViewModel {
    var apiServices: ProfileServicesProtocol?
    var model: UserDetailsModel?
    var successModel: CreateCustomerModel?
    var isFromSettings: Bool = false
    
    init(apiServices: ProfileServicesProtocol = ProfileServices()) {
        self.apiServices = apiServices
    }
    
    init(model: UserDetailsModel, isFromSettings: Bool = false, apiServices: ProfileServicesProtocol = ProfileServices()) {
        self.apiServices = apiServices
        self.isFromSettings = isFromSettings
        self.model = model
    }
    
    
//    func getUserDetails() {
//        if Reachability.isConnectedToNetwork() {
//            self.showLoadingIndicatorClosure?()
//
//            self.apiServices?.getUserDetails(finalURL: "\(Constants.Common.finalURL)/api/me", httpHeaders: [String:String](), withParameters: "", completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
//                self.hideLoadingIndicatorClosure?()
//
//                DispatchQueue.main.async {
//                    if status == true {
//                        let resultData = result as? BaseResponse<UserDetailsModel>
//                        self.model = resultData?.data
//                        self.updateView?()
//                    }
//                    else{
//                        self.alertClosure?(errorMessage ?? "Some Technical Problem")
//                    }
//                }
//            })
//        }
//        else {
//            self.alertClosure?("No Internet Availabe")
//        }
//    }
    
    func updateProfile(name: String, email: String, mob: String) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            let param = self.getCustomerParam(name: name, email: email, mob: mob)

            self.apiServices?.updateProfile(finalURL: "\(Constants.Common.finalURL)/api/user_profile_update", httpHeaders: [String:String](), withParameters: param, completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                
                DispatchQueue.main.async {
                    if status == true {
                        self.successModel = result as? CreateCustomerModel
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
    
    func getCustomerParam(name: String, email: String, mob: String) ->String {
        let jsonToReturn: NSDictionary = ["name": "\(name)", "email": "\(email)", "mob": "\(mob)"]
    return self.convertDictionaryToJsonString(dict: jsonToReturn)!
    }
}
