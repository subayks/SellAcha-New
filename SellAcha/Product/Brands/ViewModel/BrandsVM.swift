//
//  BrandsVM.swift
//  SellAcha
//
//  Created by apple on 23/10/23.
//

import UIKit

class BrandsVM: BaseViewModel {
    
    var apiServices: BrandsServiceProtocol?
    var model: [BrandsData]?
    var originalModel: [BrandsData]?
    var successModel: CreateCustomerModel?
    init(apiServices: BrandsServiceProtocol = BrandsService()) {
        self.apiServices = apiServices
    }
    
    func getBrand() {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            
            self.apiServices?.getBrand(finalURL: "\(Constants.Common.finalURL)/api/get_brand", httpHeaders: [String:String](), withParameters: "", completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                
                DispatchQueue.main.async {
                    if status == true {
                        let array = result as? BaseResponse<BrandsModel>
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
    
    func deleteCustomer(index: Int) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
           let param = self.getCustomerParam(id: String(self.model?[index].id ?? 0))
            self.apiServices?.deleteBrand(finalURL: "\(Constants.Common.finalURL)/api/destroy_brand", httpHeaders: [String:String](), withParameters: param, completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                self.model = nil
                DispatchQueue.main.async {
                    if status == true {
                        self.successModel = result as? CreateCustomerModel
                        self.getBrand()
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
    
    func getCustomerCellVM(index: Int) ->BrandsCellVM {
        BrandsCellVM(model: self.model?[index] ?? BrandsData())
    }
    
    func getCustomerVM(index: Int) ->CreateBrandsVM {
        CreateBrandsVM(model: self.model?[index] ?? BrandsData())
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
