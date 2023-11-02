//
//  LoginViewModel.swift
//  SellAcha
//
//  Created by Subaykala on 20/10/23.
//

import Foundation
class LoginViewModel: BaseViewModel {
    var apiServices: LoginApiServiceprotocol?
    var loginModel: LoginModel?
    
    init(apiServices: LoginApiServiceprotocol = LoginApiService()) {
        self.apiServices = apiServices
    }
    
    func makeLogin(email: String, password: String) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            
            let param =  self.getLoginParam(email: email, password: password)
            
            self.apiServices?.makeLogin(finalURL: "\(Constants.Common.finalURL)/api/login", httpHeaders: [String:String](), withParameters: param, completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                DispatchQueue.main.async {
                    self.hideLoadingIndicatorClosure?()
                    if status == true {
                        let model  = result as? BaseResponse<LoginModel>
                        self.loginModel = model?.data
                        let token = "Bearer " + (self.loginModel?.token ?? "")
                       print(token)
                       UserDefaults.standard.setValue(token, forKey: "AuthToken")
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
    
    func getLoginParam(email: String, password: String) ->String {
    let jsonToReturn: NSDictionary = ["email": "\(email)",
                                      "password": "\(password)"]
    return self.convertDictionaryToJsonString(dict: jsonToReturn)!
    }

}
