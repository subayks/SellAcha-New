//
//  SubscriptionVM.swift
//  SellAcha
//
//  Created by Subaykala on 27/10/23.
//

import Foundation
class SubscriptionVM: BaseViewModel {
    var apiServices: SettingsServiceProtocol?
    var model: [SubscriptionModel]?

    init(apiServices: SettingsServiceProtocol = SettingsService()) {
        self.apiServices = apiServices
    }
    
    func getSubscriptionPlan() {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            
            self.apiServices?.getSubscriptionPlan(finalURL: "\(Constants.Common.finalURL)/api/plan_details", httpHeaders: [String:String](), withParameters: "", completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                
                DispatchQueue.main.async {
                    if status == true {
                        let array = result as? BaseResponseArray<SubscriptionModel>
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
    
    func getSubscriptionCellVM(index: Int) ->SubscriptionCellVM {
        SubscriptionCellVM(model: self.model?[index] ?? SubscriptionModel())
    }
}
