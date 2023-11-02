//
//  OrdersViewModel.swift
//  SellAcha
//
//  Created by Subaykala on 12/10/23.
//

import Foundation

class OrdersViewModel: BaseViewModel {
    let filterList = ["All", "Awaiting processing", "Processing", "Ready For Pickup", "Completed", "Cancelled", "Archieved"]
    var apiServices: OrdersServiceProtocol?
    var model: OrdersModel?
    var previousIndex: Int = 0
    init(apiServices: OrdersServiceProtocol = OrdersService()) {
        self.apiServices = apiServices
    }
    
    func getAllOrders() {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            
            self.apiServices?.getAllOrders(finalURL: "\(Constants.Common.finalURL)/api/orders/all", httpHeaders: [String:String](), withParameters: "", completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                
                DispatchQueue.main.async {
                    if status == true {
                        let array = result as? BaseResponse<OrdersModel>
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
    
    func getTransactionCellVM(index: Int) ->TransactionCellVM {
        TransactionCellVM(model: self.model?.orders?.data?[index] ?? OrdersData())
    }
    
    func getPendingOrders() {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            self.apiServices?.getPendingOrders(finalURL: "\(Constants.Common.finalURL)/api/orders/pending", httpHeaders: [String:String](), withParameters: "", completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                self.model = nil
                DispatchQueue.main.async {
                    if status == true {
                        let array = result as? BaseResponse<OrdersModel>
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
    
    func getProcessingOrders() {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            self.apiServices?.getProcessingOrders(finalURL: "\(Constants.Common.finalURL)/api/orders/processing", httpHeaders: [String:String](), withParameters: "", completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                self.model = nil
                DispatchQueue.main.async {
                    if status == true {
                        let array = result as? BaseResponse<OrdersModel>
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
    
    func getOrderInfoCellVM(index: Int) ->OrderInfoCellVM {
        OrderInfoCellVM(model: self.model?.orders?.data?[index] ?? OrdersData())
    }
}
