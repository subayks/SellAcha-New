//
//  LocationVM.swift
//  SellAcha
//
//  Created by Subaykala on 25/10/23.
//

import Foundation
class LocationVM: BaseViewModel {
    
    var apiServices: ShippingServiceProtocol?
    var model: [LocationData]?
    var originalModel: [LocationData]?

    var successModel: CreateCustomerModel?
    
    init(apiServices: ShippingServiceProtocol = ShippingService()) {
        self.apiServices = apiServices
    }
    
    func getLocation() {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            
            self.apiServices?.getLocation(finalURL: "\(Constants.Common.finalURL)/api/get_location", httpHeaders: [String:String](), withParameters: "", completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                
                DispatchQueue.main.async {
                    if status == true {
                        let array = result as? BaseResponse<LocationModel>
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
    
    func deleteLocation(index: Int) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            let param = self.getCustomerParam(id: String(self.model?[index].id ?? 0))
            self.apiServices?.deleteLocation(finalURL: "\(Constants.Common.finalURL)/api/destroy_location", httpHeaders: [String:String](), withParameters: param, completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                self.model = nil
                DispatchQueue.main.async {
                    if status == true {
                        self.successModel = result as? CreateCustomerModel
                        self.getLocation()
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
        let jsonToReturn: NSDictionary = ["ids": "\(id)", "method": "delete"]
    return self.convertDictionaryToJsonString(dict: jsonToReturn)!
    }
    
    func getCustomerCellVM(index: Int) ->LocationCellVM {
        LocationCellVM(model: self.model?[index] ?? LocationData())
    }
    
    func getCustomerVM(index: Int) ->CreateLocationVM {
        CreateLocationVM(model: self.model?[index] ?? LocationData())
    }
    
    func sorting(keyword: String) {
        if keyword.count > 0 && keyword != "" {
            var postArray = [LocationData]()
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
