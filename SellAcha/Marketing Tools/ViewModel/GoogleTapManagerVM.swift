//
//  GoogleTapManagerVM.swift
//  SellAcha
//
//  Created by Subaykala on 19/10/23.
//

import Foundation
class GoogleTapManagerVM: BaseViewModel {
    let status = ["Enable", "Disable"]
    var apiServices: MarketingToolsServiceProtocol?
    var model: CreateCustomerModel?

    init(apiServices: MarketingToolsServiceProtocol = MarketingToolsService()) {
        self.apiServices = apiServices
    }

    func postGoogleTapManager(type: String, tagid: String, status: String) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            let param = self.getCustomerParam(type: type, tagid: tagid, status: status)
            self.apiServices?.postGoogleTapManager(finalURL: "\(Constants.Common.finalURL)/api/marketing", httpHeaders: [String:String](), withParameters: param, completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
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
    
    func getCustomerParam(type: String, tagid: String, status: String) ->String {
        var statusValue: Int = 0
        if status == "Enable" {
            statusValue = 1
        } else {
            statusValue = 0
        }
    let jsonToReturn: NSDictionary = ["type": "\(type)",
                                      "tag_id": "\(tagid)", "status": "\(statusValue)"
    ]
    return self.convertDictionaryToJsonString(dict: jsonToReturn)!
    }
}
