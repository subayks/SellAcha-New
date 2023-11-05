//
//  BagViewVM.swift
//  SellAcha
//
//  Created by Subaykala on 24/10/23.
//

import Foundation
class BagViewVM: BaseViewModel {
    var apiServices: BagServiceProtocol?
    var model: ProductsModel?
    var ordersDataModel: [OrdersDataModel]?
    var previousIndex: Int = 0

    init(apiServices: BagServiceProtocol = BagService()) {
        self.apiServices = apiServices
    }
    
    func createDataStructure() {
        var dataModelArray = [OrdersDataModel]()
        
        var dataModel = OrdersDataModel()
        dataModel.title = "Publish"
        dataModel.isSelected = true
        dataModel.count = String(self.model?.actives ?? 0)
        dataModel.ShowCount = true
        dataModelArray.append(dataModel)
        
        var dataModelAwaiting = OrdersDataModel()
        dataModelAwaiting.title = "Draft"
        dataModelAwaiting.isSelected = false
        dataModelAwaiting.count =  String(self.model?.drafts ?? 0)
        dataModelAwaiting.ShowCount = true
        dataModelArray.append(dataModelAwaiting)
        
        var dataModelProcessing = OrdersDataModel()
        dataModelProcessing.title = "Incomplete"
        dataModelProcessing.isSelected = false
        dataModelProcessing.count =  String(self.model?.incomplete ?? 0)
        dataModelProcessing.ShowCount = true
        dataModelArray.append(dataModelProcessing)
        
        var dataModelReady = OrdersDataModel()
        dataModelReady.title = "Trash"
        dataModelReady.isSelected = false
        dataModelReady.count =  String(self.model?.trash ?? 0)
        dataModelReady.ShowCount = true
        dataModelArray.append(dataModelReady)
        
        self.ordersDataModel = dataModelArray
        self.reloadCollectionView?()
    }
    
    func getProducts(endPoint: String) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            
            self.apiServices?.getProducts(finalURL: "\(Constants.Common.finalURL)\(endPoint)", httpHeaders: [String:String](), withParameters: "", completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                
                DispatchQueue.main.async {
                    if status == true {
                        let array = result as? BaseResponse<ProductsModel>
                        self.model = array?.data
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
    
    func getBagTableViewCellVM(index: Int) ->BagTableViewCellVM {
        BagTableViewCellVM(model: self.model?.posts?.data?[index] ?? ProductsData())
    }
    
    func retriveProfile() ->ProfileModel?{
        let obj = UserDefaults.standard.retrieve(object: ProfileModel.self, fromKey: "Profile")
        return obj
    }
}
