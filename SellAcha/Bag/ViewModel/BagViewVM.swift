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
    let filterList = ["All", "Awaiting processing", "Processing", "Ready For Pickup", "Completed", "Cancelled", "Archieved"]
    var previousIndex: Int = 0

    init(apiServices: BagServiceProtocol = BagService()) {
        self.apiServices = apiServices
    }
    
    func getProducts() {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            
            self.apiServices?.getProducts(finalURL: "\(Constants.Common.finalURL)/api/product?type=products", httpHeaders: [String:String](), withParameters: "", completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                
                DispatchQueue.main.async {
                    if status == true {
                        let array = result as? BaseResponse<ProductsModel>
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
    
    func getBagTableViewCellVM(index: Int) ->BagTableViewCellVM {
        BagTableViewCellVM(model: self.model?.posts?.data?[index] ?? ProductsData())
    }
}
