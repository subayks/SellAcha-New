//
//  OrdersViewModel.swift
//  SellAcha
//
//  Created by Subaykala on 12/10/23.
//

import Foundation

struct OrdersDataModel {
    var title: String?
    var isSelected: Bool?
    var count: String?
    var ShowCount: Bool?
}

class OrdersViewModel: BaseViewModel {
    let filterList = ["All", "Awaiting processing", "Processing", "Ready For Pickup", "Completed", "Cancelled", "Archieved"]
    var ordersDataModel: [OrdersDataModel]?
    var apiServices: OrdersServiceProtocol?
    var model: OrdersModel?
    var originalModel: OrdersModel?
    var previousIndex: Int = 0
    init(apiServices: OrdersServiceProtocol = OrdersService()) {
        self.apiServices = apiServices
    }
    
    func createDataStructure() {
        var dataModelArray = [OrdersDataModel]()
        
        var dataModel = OrdersDataModel()
        dataModel.title = "All"
        dataModel.isSelected = true
        dataModel.count = "0"
        dataModel.ShowCount = false
        dataModelArray.append(dataModel)
        
        var dataModelAwaiting = OrdersDataModel()
        dataModelAwaiting.title = "Awaiting processing"
        dataModelAwaiting.isSelected = false
        dataModelAwaiting.count = String(self.model?.pendings ?? 0)
        dataModelAwaiting.ShowCount = true
        dataModelArray.append(dataModelAwaiting)
        
        var dataModelProcessing = OrdersDataModel()
        dataModelProcessing.title = "Processing"
        dataModelProcessing.isSelected = false
        dataModelProcessing.count = String(self.model?.processing ?? 0)
        dataModelProcessing.ShowCount = true
        dataModelArray.append(dataModelProcessing)
        
        var dataModelReady = OrdersDataModel()
        dataModelReady.title = "Ready For Pickup"
        dataModelReady.isSelected = false
        dataModelReady.count = String(self.model?.pickup ?? 0)
        dataModelReady.ShowCount = true
        dataModelArray.append(dataModelReady)
        
        var dataModelReadyCompleted = OrdersDataModel()
        dataModelReadyCompleted.title = "Completed"
        dataModelReadyCompleted.isSelected = false
        dataModelReadyCompleted.count = String(self.model?.completed ?? 0)
        dataModelReadyCompleted.ShowCount = true
        dataModelArray.append(dataModelReadyCompleted)
        
        var dataModelCancelled = OrdersDataModel()
        dataModelCancelled.title = "Cancelled"
        dataModelCancelled.isSelected = false
        dataModelCancelled.count = String(self.model?.canceled ?? 0)
        dataModelCancelled.ShowCount = true
        dataModelArray.append(dataModelCancelled)
        
        var dataModelArchieved = OrdersDataModel()
        dataModelArchieved.title = "Archieved"
        dataModelArchieved.isSelected = false
        dataModelArchieved.count = String(self.model?.archived ?? 0)
        dataModelArchieved.ShowCount = true
        dataModelArray.append(dataModelArchieved)
        
        self.ordersDataModel = dataModelArray
        self.reloadCollectionView?()
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
                        self.originalModel = array?.data
                        self.createDataStructure()
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
    
    func getProcessingOrders(orderType: String) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            self.apiServices?.getProcessingOrders(finalURL: "\(Constants.Common.finalURL)/api/orders/\(orderType)", httpHeaders: [String:String](), withParameters: "", completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
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
