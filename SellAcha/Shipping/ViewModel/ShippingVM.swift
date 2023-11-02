//
//  ShippingVM.swift
//  SellAcha
//
//  Created by Subaykala on 25/10/23.
//

import Foundation
class ShippingVM: BaseViewModel {
    
    var apiServices: ShippingServiceProtocol?
    var model: [ShippingData]?
    var originalModel: [ShippingData]?
    var successModel: CreateCustomerModel?
    
    init(apiServices: ShippingServiceProtocol = ShippingService()) {
        self.apiServices = apiServices
    }
    
    func getShipping() {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            
            self.apiServices?.getShipping(finalURL: "\(Constants.Common.finalURL)/api/get_shipping", httpHeaders: [String:String](), withParameters: "", completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                
                DispatchQueue.main.async {
                    if status == true {
                        let array = result as? BaseResponse<ShippingModel>
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
    
    func deleteShipping(index: Int) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            let param = self.getCustomerParam(id: String(self.model?[index].id ?? 0))
            self.apiServices?.deleteShipping(finalURL: "\(Constants.Common.finalURL)/api/destroy_shipping", httpHeaders: [String:String](), withParameters: param, completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                self.model = nil
                DispatchQueue.main.async {
                    if status == true {
                        self.successModel = result as? CreateCustomerModel
                        self.getShipping()
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
        let jsonToReturn: NSDictionary = ["ids": "\(id)", "method": "delete"]
    return self.convertDictionaryToJsonString(dict: jsonToReturn)!
    }
    
    func getCustomerCellVM(index: Int) ->ShippingCellVM {
        ShippingCellVM(model: self.model?[index] ?? ShippingData())
    }
    
    func getCustomerVM(index: Int) ->CreateShippingVM {
        CreateShippingVM(model: self.model?[index] ?? ShippingData())
    }
    
    func sorting(keyword: String) {
        if keyword.count > 0 && keyword != "" {
            var postArray = [ShippingData]()
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
