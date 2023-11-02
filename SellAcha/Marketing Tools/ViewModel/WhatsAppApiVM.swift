//
//  WhatsAppApiVM.swift
//  SellAcha
//
//  Created by Subaykala on 19/10/23.
//

import Foundation
class WhatsAppApiVM: BaseViewModel {
    let status = ["Enable", "Disable"]
    var apiServices: MarketingToolsServiceProtocol?
    var model: CreateCustomerModel?

    init(apiServices: MarketingToolsServiceProtocol = MarketingToolsService()) {
        self.apiServices = apiServices
    }

    func postWhatsApp(type: String, number: String, status: String, shopPagePretext: String, otherPagePretext: String) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            let param = self.getCustomerParam(type: type, number: number, status: status, shopPagePretext: shopPagePretext, otherPagePretext: otherPagePretext)
            self.apiServices?.postWhatsApp(finalURL: "\(Constants.Common.finalURL)/api/marketing", httpHeaders: [String:String](), withParameters: param, completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
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
    
    func getCustomerParam(type: String, number: String, status: String, shopPagePretext: String, otherPagePretext: String) ->String {
        var statusValue: Int = 0
        if status == "Enable" {
            statusValue = 1
        } else {
            statusValue = 0
        }
    let jsonToReturn: NSDictionary = ["type": "\(type)",
                                      "number": "\(number)", "status": "\(statusValue)", "shop_page_pretext": "\(shopPagePretext)", "other_page_pretext": "\(otherPagePretext)"
    ]
    return self.convertDictionaryToJsonString(dict: jsonToReturn)!
    }
}
