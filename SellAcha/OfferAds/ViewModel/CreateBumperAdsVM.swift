//
//  CreateBumperAdsVM.swift
//  SellAcha
//
//  Created by Subaykala on 26/10/23.
//

import Foundation
import UIKit
class CreateBumperAdsVM: BaseViewModel {
    var apiServices: AdServiceProtocol?
    var model: BumpAdModel?
    var successModel: CreateCustomerModel?
    var selectedImage: UIImage?

    init(apiServices: AdServiceProtocol = AdService()) {
        self.apiServices = apiServices
    }
    
    func createBumpAd(url: String) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            let param = self.getParam(url: url)
            self.apiServices?.createBumpAd(finalURL: "\(Constants.Common.finalURL)/api/ads_store?url=\(url)", httpHeaders: [String:String](), withParameters: "", completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                
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
    
    func getParam(url: String) ->String{
    let jsonToReturn: NSDictionary = ["url": "\(url)"]
    return self.convertDictionaryToJsonString(dict: jsonToReturn)!
    }
}
