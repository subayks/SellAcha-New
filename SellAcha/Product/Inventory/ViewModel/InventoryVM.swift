//
//  InventoryVM.swift
//  SellAcha
//
//  Created by apple on 23/10/23.
//

import UIKit

class InventoryVM: BaseViewModel{
    
    var apiServices: InventoryServiceProtocol?
    var model: [InventoryData]?
    var originalModel: [InventoryData]?
    
    init(apiServices: InventoryServiceProtocol = InventoryService()) {
        self.apiServices = apiServices
    }
    
    func inventoryCall() {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()

            self.apiServices?.inventoryCall(finalURL: "\(Constants.Common.finalURL)/api/inventory", httpHeaders: [String:String](), withParameters: "", completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()

                DispatchQueue.main.async {
                    if status == true {
                        let array = result as? BaseResponse<InventoryModel>
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
    
    func getInventoryCellVM(index: Int) ->InventoryCellVM {
        InventoryCellVM(model: self.model?[index] ?? InventoryData())
    }
    
    func sorting(keyword: String) {
        if keyword.count > 0 && keyword != "" {
            var postArray = [InventoryData]()
            if let posts = self.originalModel {
                for item in posts {
                    if item.sku!.lowercased().contains(keyword.lowercased()) {
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
