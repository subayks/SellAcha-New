//
//  HomeViewModel.swift
//  SellAcha
//
//  Created by Subaykala on 12/10/23.
//

import Foundation

class HomeViewModel: BaseViewModel {
    var apiServices: HomeApiServicesProtocol?
    var staticDataModel: StaticData?
    var performanceData: PerformanceData?
    var visitorAnalytics: VisitorAnalytics?
    var orderStaticsData: OrderStaticsData?
    
    var monthDropDown = ["Jan", "Feb", "March", "April", "May", "June", "July", "Aug", "Sept", "Oct", "Nov", "Dec"]

    var month = ["Jan", "Feb", "March", "April", "May", "June", "July", "Aug", "Sept", "Oct", "Nov", "Dec"]
    var unitsSold = [24.0,43.0,56.0,23.0,56.0,68.0,48.0,120.0,41.0,34.0,55.9,12.0,34.0]
    var month2 = ["Jan", "Feb", "March", "April", "May", "June", "July", "Aug", "Sept", "Oct", "Nov", "Dec"]
    var unitsSold2 = [1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,5.0]
    
    init(apiServices: HomeApiServicesProtocol = HomeApiService()) {
        self.apiServices = apiServices
    }
    
    func getStaticData() {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            
            self.apiServices?.getStaticData(finalURL: "\(Constants.Common.finalURL)/api/dashboard/static", withParameters: "", completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()

                DispatchQueue.main.async {
                    if status == true {
                        let array = result as? BaseResponse<StaticData>
                        self.staticDataModel = array?.data
                        if let orders = self.staticDataModel?.orders {
                            self.unitsSold2.removeAll()
                            self.month2.removeAll()
                            for item in orders {
                                self.unitsSold2.append(Double(item.sales ?? 0))
                                self.month2.append(item.month ?? "")
                            }
                        }
                        self.getPerformanceData(count: "15")
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
    
    func getPerformanceData(count: String) {
        if Reachability.isConnectedToNetwork() {
         //   self.showLoadingIndicatorClosure?()
            
            self.apiServices?.getPerformanceData(finalURL: "\(Constants.Common.finalURL)/api/dashboard/perfomance/\(count)", withParameters: "", completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()

                DispatchQueue.main.async {
                    if status == true {
                        self.performanceData = result as? PerformanceData
                        if let performance = self.performanceData?.data {
                            self.unitsSold.removeAll()
                            self.month.removeAll()
                            for item in performance {
                                self.unitsSold.append(Double(item.total ?? 0))
                                let date = item.date?.toDate()
                                self.month.append(date?.month ?? "")
                            }
                        }
                        self.getOrderStatics(month: "Jan")
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
    
    func getOrderStatics(month: String) {
        if Reachability.isConnectedToNetwork() {
          //  self.showLoadingIndicatorClosure?()
            
            let param = self.getMonthParam(month: month)
            
            self.apiServices?.getOrderStatics(finalURL: "\(Constants.Common.finalURL)/api/dashboard/order_statics", httpHeaders: [String:String]() , withParameters: param, completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()

                DispatchQueue.main.async {
                    if status == true {
                        let array = result as? BaseResponse<OrderStaticsData>
                        self.orderStaticsData = array?.data
                        self.updateView?()
                    //    self.getVisitorAnalytics(count: "15")
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
    
    func getVisitorAnalytics(count: String) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            
            self.apiServices?.getVisitorAnalytics(finalURL: "\(Constants.Common.finalURL)/api/dashboard/visitors/\(count)", withParameters: "", completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                DispatchQueue.main.async {
                    self.hideLoadingIndicatorClosure?()
                    if status == true {
                        self.visitorAnalytics = result as? VisitorAnalytics
                        self.updateView?()
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
    
    func getMonthParam(month: String) ->String {
    let jsonToReturn: NSDictionary = ["month": "\(month)"]
    return self.convertDictionaryToJsonString(dict: jsonToReturn)!
    }
    
    func getMonth(date: Date) ->String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let nameOfMonth = dateFormatter.string(from: date)
        return nameOfMonth
    }
}

extension Date {
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }
}

extension String {

    func toDate(withFormat format: String = "yyyy-MM-dd")-> Date?{

        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tehran")
        dateFormatter.locale = Locale(identifier: "fa-IR")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)

        return date

    }
}
