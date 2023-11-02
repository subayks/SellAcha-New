//
//  CreateCouponsVM.swift
//  SellAcha
//
//  Created by Subaykala on 24/10/23.
//

import Foundation
class CreateCouponsVM: BaseViewModel {
    var apiServices: CouponsServiceProtocol?
    var model: CouponsData?
    var successModel: CreateCustomerModel?
    
    init(apiServices: CouponsServiceProtocol = CouponsService()) {
        self.apiServices = apiServices
    }
    
    init(model: CouponsData, apiServices: CouponsServiceProtocol = CouponsService()) {
        self.model = model
        self.apiServices = apiServices
    }
    
    func createCoupons(coupon: String, percent: String, date: String) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            let param = self.getCustomerParam(coupon: coupon, percent: percent, date: date)
            self.apiServices?.createCoupons(finalURL: "\(Constants.Common.finalURL)/api/create_coupon", httpHeaders: [String:String](), withParameters: param, completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
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
    
    func editCoupons(coupon: String, percent: String, date: String, id: String) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            let param = self.getEditCustomerParam(coupon: coupon, percent: percent, date: date, id: id)
            self.apiServices?.editCoupons(finalURL: "\(Constants.Common.finalURL)/api/edit_coupon", httpHeaders: [String:String](), withParameters: param, completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                self.model = nil
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
    
    func getCustomerParam(coupon: String, percent: String, date: String) ->String {
    let jsonToReturn: NSDictionary = ["coupon_code": "\(coupon)",
                                      "percent": "\(percent)", "date": "\(date)"
    ]
    return self.convertDictionaryToJsonString(dict: jsonToReturn)!
    }
    
    func getEditCustomerParam(coupon: String, percent: String, date: String, id: String) ->String {
    let jsonToReturn: NSDictionary = ["coupon_code": "\(coupon)",
                                      "percent": "\(percent)", "date": "\(date)", "id": "\(id)"
    ]
    return self.convertDictionaryToJsonString(dict: jsonToReturn)!
    }
    
    func getEditCustomerParam(name: String, featured: String, file: String) ->String {
    let jsonToReturn: NSDictionary = ["name": "\(name)",
                                      "featured": "\(featured)", "file": "\(file)", "id": "\(self.model?.id ?? 0)"
    ]
    return self.convertDictionaryToJsonString(dict: jsonToReturn)!
    }
}
