//
//  BumperAdsVM.swift
//  SellAcha
//
//  Created by Subaykala on 26/10/23.
//

import Foundation
class BumperAdsVM: BaseViewModel {
    var apiServices: AdServiceProtocol?
    var model: BumpAdModel?
    var successModel: CreateCustomerModel?
    
    init(apiServices: AdServiceProtocol = AdService()) {
        self.apiServices = apiServices
    }
    
    func getBumpAd() {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            
            self.apiServices?.getBumpAd(finalURL: "\(Constants.Common.finalURL)/api/ads", httpHeaders: [String:String](), withParameters: "", completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                
                DispatchQueue.main.async {
                    if status == true {
                        let array = result as? BaseResponse<BumpAdModel>
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
    
    func getBumperAdCellVM(index: Int) ->BumperAdCellVM {
        BumperAdCellVM(model: self.model?.data?[index] ?? BumpAdData())
    }
}
