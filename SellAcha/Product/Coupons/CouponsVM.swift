//
//  CouponsVM.swift
//  SellAcha
//
//  Created by apple on 23/10/23.
//

import UIKit

class CouponsVM: BaseViewModel {
    
    var apiServices: CouponsServiceProtocol?
    var model: [CouponsData]?
    var originalModel: [CouponsData]?

    var successModel: CreateCustomerModel?
    
    init(apiServices: CouponsServiceProtocol = CouponsService()) {
        self.apiServices = apiServices
    }
    
    func getCoupons() {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            
            self.apiServices?.getCoupons(finalURL: "\(Constants.Common.finalURL)/api/get_coupon", httpHeaders: [String:String](), withParameters: "", completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                
                DispatchQueue.main.async {
                    if status == true {
                        let array = result as? BaseResponse<CouponsModel>
                        self.model = array?.data?.posts?.data
                        self.originalModel = array?.data?.posts?.data
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
    
    func deleteCoupons(index: Int) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
           let param = self.getCustomerParam(id: String(self.model?[index].id ?? 0))
            self.apiServices?.deleteCoupons(finalURL: "\(Constants.Common.finalURL)/api/destroy_coupon", httpHeaders: [String:String](), withParameters: param, completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                self.model = nil
                DispatchQueue.main.async {
                    if status == true {
                        self.successModel = result as? CreateCustomerModel
                        self.getCoupons()
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
    
    func getCustomerParam(id: String) ->String {
        let jsonToReturn: NSDictionary = ["id": "\(id)", "type": "delete"]
    return self.convertDictionaryToJsonString(dict: jsonToReturn)!
    }
    
    func getCustomerCellVM(index: Int) ->CouponsCellVM {
       CouponsCellVM(model: self.model?[index] ?? CouponsData())
    }
    
    func getCustomerVM(index: Int) ->CreateCouponsVM {
        CreateCouponsVM(model: self.model?[index] ?? CouponsData())
    }
    
    func sorting(keyword: String) {
        if keyword.count > 0 && keyword != "" {
            var postArray = [CouponsData]()
            if let posts = self.originalModel {
                for item in posts {
                    if item.name!.lowercased().contains(keyword.lowercased()) {
                        postArray.append(item)
                    }
                }
            }
            self.model = postArray
        } else {
            self.model = self.originalModel
        }
        self.reloadTableView?()
    }
}
