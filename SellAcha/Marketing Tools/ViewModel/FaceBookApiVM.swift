//
//  FaceBookApiVM.swift
//  SellAcha
//
//  Created by Subaykala on 19/10/23.
//

import Foundation
class FaceBookApiVM: BaseViewModel {
    let status = ["Enable", "Disable"]
    var apiServices: MarketingToolsServiceProtocol?
    var model: CreateCustomerModel?

    init(apiServices: MarketingToolsServiceProtocol = MarketingToolsService()) {
        self.apiServices = apiServices
    }
    
    func postFaceBook(type: String, pixelid: String, status: String) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            let param = self.getCustomerParam(type: type, pixelid: pixelid, status: status)
            self.apiServices?.postFaceBook(finalURL: "\(Constants.Common.finalURL)/api/marketing", httpHeaders: [String:String](), withParameters: param, completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
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
    
    func getCustomerParam(type: String, pixelid: String, status: String) ->String {
        var statusValue: Int = 0
        if status == "Enable" {
            statusValue = 1
        } else {
            statusValue = 0
        }
    let jsonToReturn: NSDictionary = ["type": "\(type)",
                                      "pixel_id": "\(pixelid)", "status": "\(statusValue)"
    ]
    return self.convertDictionaryToJsonString(dict: jsonToReturn)!
    }

}
