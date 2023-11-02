//
//  AttributeVM.swift
//  SellAcha
//
//  Created by apple on 23/10/23.
//

import UIKit

class AttributeVM: BaseViewModel {
    
    var apiServices: AttributeServiceProtocol?
    var model: [AttributeData]?
    var originalModel: [AttributeData]?
    var successModel: CreateCustomerModel?
    
    init(apiServices: AttributeServiceProtocol = AttributeService()) {
        self.apiServices = apiServices
    }
    
    func getAttributes() {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            
            self.apiServices?.getAttributes(finalURL: "\(Constants.Common.finalURL)/api/get_attribute", httpHeaders: [String:String](), withParameters: "", completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                
                DispatchQueue.main.async {
                    if status == true {
                        let array = result as? BaseResponse<AttributeModel>
                        self.model = array?.data?.posts
                        self.originalModel = array?.data?.posts
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
    
    func deleteAttributes(index: Int) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
           let param = self.getCustomerParam(id: String(self.model?[index].id ?? 0))
            self.apiServices?.deleteAttributes(finalURL: "\(Constants.Common.finalURL)/api/destroy_attribute", httpHeaders: [String:String](), withParameters: param, completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                self.model = nil
                DispatchQueue.main.async {
                    if status == true {
                        self.successModel = result as? CreateCustomerModel
                        self.getAttributes()
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
    
    func getCustomerCellVM(index: Int) ->AttributeCellVM {
        AttributeCellVM(model: self.model?[index] ?? AttributeData())
    }
    
    func getCustomerVM(index: Int) ->CreateAttributeVM {
        CreateAttributeVM(model: self.model?[index] ?? AttributeData())
    }
    
    func sorting(keyword: String) {
        if keyword.count > 0 && keyword != "" {
            var postArray = [AttributeData]()
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
