//
//  BannerAdsVM.swift
//  SellAcha
//
//  Created by Subaykala on 26/10/23.
//

import Foundation
class BannerAdsVM: BaseViewModel {
    var apiServices: AdServiceProtocol?
    var model: BannerAdModel?
    var successModel: CreateCustomerModel?
    
    init(apiServices: AdServiceProtocol = AdService()) {
        self.apiServices = apiServices
    }
    
    func getBannerAd() {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            
            self.apiServices?.getBannerAd(finalURL: "\(Constants.Common.finalURL)/api/banner_ads", httpHeaders: [String:String](), withParameters: "", completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                
                DispatchQueue.main.async {
                    if status == true {
                        let array = result as? BaseResponse<BannerAdModel>
                        self.model = array?.data
                        self.reloadTableView?()
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
    
    func getBannerAdCellVM(index: Int) ->BannerAdCellVM {
        BannerAdCellVM(model: self.model?.data?[index] ?? BannerAdData())
    }
}
