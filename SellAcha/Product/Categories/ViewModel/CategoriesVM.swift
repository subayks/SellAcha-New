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
    var model: [BrandsData]?
    var originalModel: [BrandsData]?
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
    
    func getCategoriesCellVM(index: Int) ->CategoriesCellVM {
        CategoriesCellVM(model: self.model?[index] ?? BrandsData() )
    }
    
    func deleteCategories(index: Int) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            let param = self.getCustomerParam(id: String(self.model?[index].id ?? 0))
            self.apiServices?.deleteCategories(finalURL: "\(Constants.Common.finalURL)/api/destroy_category", httpHeaders: [String:String](), withParameters: param, completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                self.model = nil
                DispatchQueue.main.async {
                    if status == true {
                        self.successModel = result as? CreateCustomerModel
                        self.getCategories()
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
        let jsonToReturn: NSDictionary = ["ids": "\(id)", "method": "delete", "typeu": "category"]
    return self.convertDictionaryToJsonString(dict: jsonToReturn)!
    }


    func getCustomerVM(index: Int) ->CreateCategoriesVM {
        CreateCategoriesVM(model: self.model?[index] ?? BrandsData())
    }
    
    func sorting(keyword: String) {
        if keyword.count > 0 && keyword != "" {
            var postArray = [BrandsData]()
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
