//
//  CustomerListVM.swift
//  SellAcha
//
//  Created by Subaykala on 23/10/23.
//

import Foundation
class CustomerListVM: BaseViewModel {
    var apiServices: CustomerServicesProtocol?
    var model: CustomerModel?
    var customerModel: CreateCustomerModel?
    init(apiServices: CustomerServicesProtocol = CustomerServices()) {
        self.apiServices = apiServices
    }
    
    func getCustomer() {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            
            self.apiServices?.getCustomer(finalURL: "\(Constants.Common.finalURL)/api/get_customer", httpHeaders: [String:String](), withParameters: "", completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                
                DispatchQueue.main.async {
                    if status == true {
                        let array = result as? BaseResponse<CustomerModel>
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
    
    func filterCustomer(keyword: String) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            self.apiServices?.filterCustomer(finalURL: "\(Constants.Common.finalURL)/api/get_customer?type=name?src=\(keyword)", httpHeaders: [String:String](), withParameters: "", completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                self.model = nil
                DispatchQueue.main.async {
                    if status == true {
                        let array = result as? BaseResponse<CustomerModel>
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
    
    func deleteCustomer(index: Int) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            let param = self.getCustomerParam(id: String(self.model?.posts?.data?[index].id ?? 0))
            self.apiServices?.deleteCustomer(finalURL: "\(Constants.Common.finalURL)/api/destroy_customer", httpHeaders: [String:String](), withParameters: param, completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                self.model = nil
                DispatchQueue.main.async {
                    if status == true {
                        self.customerModel = result as? CreateCustomerModel
                        self.getCustomer()
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
        let jsonToReturn: NSDictionary = ["ids": "\(id)", "type": "delete"]
    return self.convertDictionaryToJsonString(dict: jsonToReturn)!
    }
    
    func getCustomerCellVM(index: Int) ->CustomerCellVM {
        CustomerCellVM(model: self.model?.posts?.data?[index] ?? Customer())
    }
    
    func getCustomerVM(index: Int) ->CustomerVM {
        CustomerVM(model: self.model?.posts?.data?[index] ?? Customer())
    }
}

