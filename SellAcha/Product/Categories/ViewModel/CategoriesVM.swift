//
//  CategoriesVM.swift
//  SellAcha
//
//  Created by apple on 23/10/23.
//

import UIKit
import Foundation

class CategoriesVM: BaseViewModel {
    
    var apiServices: CategoriesServiceProtocol?
    var model: CategorieModel?
    var successModel: CreateCustomerModel?
    
    init(apiServices: CategoriesServiceProtocol = CategoriesService()) {
        self.apiServices = apiServices
    }
    
    func getCategories() {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            
            self.apiServices?.getCategories(finalURL: "\(Constants.Common.finalURL)/api/get_category?type=category", httpHeaders: [String:String](), withParameters: "", completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                
                DispatchQueue.main.async {
                    if status == true {
                        let array = result as? BaseResponse<CategorieModel>
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
    
//    func deleteCategories(index: Int) {
//        if Reachability.isConnectedToNetwork() {
//            self.showLoadingIndicatorClosure?()
//           let param = self.getCustomerParam(id: String(self.model?.posts?[index].id ?? 0))
//            self.apiServices?.deleteCategories(finalURL: "\(Constants.Common.finalURL)/api/destroy_attribute", httpHeaders: [String:String](), withParameters: param, completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
//                self.hideLoadingIndicatorClosure?()
//                self.model = nil
//                DispatchQueue.main.async {
//                    if status == true {
//                        self.successModel = result as? CreateCustomerModel
//                        self.getCategories()
//                    }
//                    else{
//                        self.alertClosure?(errorMessage ?? "Some Technical Problem")
//                    }
//                }
//            })
//        }
//        else {
//            self.alertClosure?("No Internet Availabe")
//        }
//    }
//
//    func getCustomerParam(id: String) ->String {
//        let jsonToReturn: NSDictionary = ["ids": "\(id)", "method": "delete", "typeu": "category"]
//    return self.convertDictionaryToJsonString(dict: jsonToReturn)!
//    }
//
//    func getCustomerCellVM(index: Int) ->CategoriesCellVM {
//        CategoriesCellVM(model: self.model?.posts?[index] ?? AttributeData())
//    }
//
//    func getCustomerVM(index: Int) ->CreateCategoriesVM {
//        CreateCategoriesVM(model: self.model?.posts?[index] ?? AttributeData())
//    }
    
}
