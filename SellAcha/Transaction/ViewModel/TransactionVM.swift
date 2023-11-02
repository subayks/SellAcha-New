//
//  TransactionVM.swift
//  SellAcha
//
//  Created by Subaykala on 22/10/23.
//

import Foundation
class TransactionVM: BaseViewModel {
    var apiServices: TransactionServiceProtocol?
    var model: TransactionModel?
    
    init(apiServices: TransactionServiceProtocol = TransactionService()) {
        self.apiServices = apiServices
    }
    
    func getTransactionList() {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            
            self.apiServices?.getTransaction(finalURL: "\(Constants.Common.finalURL)/api/get_transaction", httpHeaders: [String:String](), withParameters: "", completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                
                DispatchQueue.main.async {
                    if status == true {
                        let array = result as? BaseResponse<TransactionModel>
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
    
    func getTransactionbyID(keyword: String) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            self.apiServices?.getTransactionById(finalURL: "\(Constants.Common.finalURL)/api/get_transaction?src=\(keyword)", httpHeaders: [String:String](), withParameters: "", completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                self.model = nil
                DispatchQueue.main.async {
                    if status == true {
                        let array = result as? BaseResponse<TransactionModel>
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
}
