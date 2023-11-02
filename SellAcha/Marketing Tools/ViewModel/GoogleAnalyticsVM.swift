//
//  GoogleAnalyticsVM.swift
//  SellAcha
//
//  Created by Subaykala on 19/10/23.
//

import Foundation

class GoogleAnalyticsVM: BaseViewModel{
    let status = ["Enable", "Disable"]
    var apiServices: MarketingToolsServiceProtocol?
    var model: CreateCustomerModel?

    init(apiServices: MarketingToolsServiceProtocol = MarketingToolsService()) {
        self.apiServices = apiServices
    }
    
    func postGoogleAnalytics(param: String) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            let param = self.getCustomerParam(param: param)
            self.apiServices?.postGoogleAnalytics(finalURL: "\(Constants.Common.finalURL)/get_marketing", httpHeaders: [String:String](), withParameters: param, completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
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
    
    func getCustomerParam(param: String) ->String {
    let jsonToReturn: NSDictionary = ["param": "\(param)"
    ]
    return self.convertDictionaryToJsonString(dict: jsonToReturn)!
    }
}
