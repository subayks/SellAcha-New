//
//  CreateCategoriesVM.swift
//  SellAcha
//
//  Created by Subaykala on 26/10/23.
//

import Foundation
class CreateCategoriesVM: BaseViewModel {
    var apiServices: CategoriesServiceProtocol?
    var model: AttributeData?
    var successModel: CreateCustomerModel?
    
    init(apiServices: CategoriesServiceProtocol = CategoriesService()) {
        self.apiServices = apiServices
    }
    
    init(model: AttributeData, apiServices: CategoriesServiceProtocol = CategoriesService()) {
        self.model = model
        self.apiServices = apiServices
    }
    
    func createCategories(name: String, type: String, featured: String, menuStatus: String) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            let param = self.getCustomerParam(name: name, type: type, featured: featured, menuStatus: menuStatus)
            self.apiServices?.createCategories(finalURL: "\(Constants.Common.finalURL)/api/create_category", httpHeaders: [String:String](), withParameters: param, completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                
                DispatchQueue.main.async {
                    if status == true {
                    //    self.successModel = result as? CreateCustomerModel
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
    
    func editCategories(name: String, type: String, featured: String, menuStatus: String) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            let param = self.getEditCustomerParam(name: name, type: type, featured: featured, menuStatus: menuStatus)
            self.apiServices?.editCategories(finalURL: "\(Constants.Common.finalURL)/api/edit_category", httpHeaders: [String:String](), withParameters: param, completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
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
    
    func getCustomerParam(name: String, type: String, featured: String, menuStatus: String) ->String {
        var status = 0
        if featured == "Active" {
            status = 1
        } else {
            status = 0
        }
        var menu = 0
        if menuStatus == "" {
            menu = 1
        } else {
            menu = 0
        }
    let jsonToReturn: NSDictionary = ["name": "\(name)",
                                      "type": "\(type)", "featured": "\(status)", "menu_status": "\(menu)"
    ]
    return self.convertDictionaryToJsonString(dict: jsonToReturn)!
    }
    
    func getEditCustomerParam(name: String, type: String, featured: String, menuStatus: String) ->String {
        var status = 0
        if featured == "Yes" {
            status = 1
        } else {
            status = 0
        }
        var menu = 0
        if menuStatus == "Yes" {
            menu = 1
        } else {
            menu = 0
        }
    let jsonToReturn: NSDictionary = ["name": "\(name)",
                                      "type": "\(type)", "featured": "\(status)", "menu_status": "\(menu)", "id": "\(self.model?.id ?? 0)"
    ]
    return self.convertDictionaryToJsonString(dict: jsonToReturn)!
    }

}
