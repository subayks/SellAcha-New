//
//  CreateBannerAdsVM.swift
//  SellAcha
//
//  Created by Subaykala on 26/10/23.
//

import Foundation
import UIKit

class CreateBannerAdsVM: BaseViewModel {
    var apiServices: AdServiceProtocol?
    var model: BumpAdModel?
    var successModel: CreateCustomerModel?
    var selectedImage: UIImage?

    init(apiServices: AdServiceProtocol = AdService()) {
        self.apiServices = apiServices
    }
    
    func createBannerAd(url: String) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            let param = self.getParam(url: url)
            self.apiServices?.createBannerAd(finalURL: "\(Constants.Common.finalURL)/api/banner_store", httpHeaders: [String:String](), withParameters: param, completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
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
