//
//  CreateOrderVM.swift
//  SellAcha
//
//  Created by Subaykala on 07/11/23.
//

import Foundation
class CreateOrderVM: BaseViewModel {
    var apiServices: OrdersServiceProtocol?
    var model: [ProductsData]?
    var originalModel: [ProductsData]?
    
    init(apiServices: OrdersServiceProtocol = OrdersService()) {
        self.apiServices = apiServices
    }
    
    func createShow() {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            
            self.apiServices?.createShow(finalURL: "\(Constants.Common.finalURL)/api/create_show", httpHeaders: [String:String](), withParameters: "", completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                
                DispatchQueue.main.async {
                    if status == true {
                        let array = result as? BaseResponse<CreateShowModel>
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
    
    func getBagTableViewCellVM(index: Int) ->BagTableViewCellVM {
        BagTableViewCellVM(model: self.model?[index] ?? ProductsData())
    }
    
    func sorting(keyword: String) {
        if keyword.count > 0 && keyword != "" {
            var postArray = [ProductsData]()
            if let posts = self.originalModel {
                for item in posts {
                    if item.title!.lowercased().contains(keyword.lowercased()) {
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
