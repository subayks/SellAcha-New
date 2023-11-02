//
//  ReportsVM.swift
//  SellAcha
//
//  Created by Subaykala on 23/10/23.
//

import Foundation
class ReportsVM: BaseViewModel {
    var apiServices: ReportsServiceProtocol?
    var model: ReportsModel?
    
    init(apiServices: ReportsServiceProtocol = ReportsService()) {
        self.apiServices = apiServices
    }
    
    func getReportList() {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            
            self.apiServices?.getReports(finalURL: "\(Constants.Common.finalURL)/api/get_report", httpHeaders: [String:String](), withParameters: "", completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                
                DispatchQueue.main.async {
                    if status == true {
                        let array = result as? BaseResponse<ReportsModel>
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
    
    func getReportsCellVM(index: Int) ->ReportsCellVM {
        ReportsCellVM(model: self.model?.orders?.data?[index] ?? OrdersData())
    }
    
    func getTransactionbyID(startDate: String, endDate: String) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            self.apiServices?.getReportsById(finalURL: "\(Constants.Common.finalURL)/api/get_transaction?get_report?start=\(startDate)&end=\(endDate)", httpHeaders: [String:String](), withParameters: "", completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                self.model = nil
                DispatchQueue.main.async {
                    if status == true {
                        let array = result as? BaseResponse<ReportsModel>
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
