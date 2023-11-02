//
//  CreateBrandsVM.swift
//  SellAcha
//
//  Created by Subaykala on 24/10/23.
//

import Foundation
import UIKit
import Photos

class CreateBrandsVM: BaseViewModel {
    var apiServices: BrandsServiceProtocol?
    var model: BrandsData?
    var successModel: CreateCustomerModel?
    var status = ["Yes", "No"]
    var selectedImage: UIImage? 
    
    init(apiServices: BrandsServiceProtocol = BrandsService()) {
        self.apiServices = apiServices
    }
    
    init(model: BrandsData, apiServices: BrandsServiceProtocol = BrandsService()) {
        self.model = model
        self.apiServices = apiServices
    }
    
    func createBrand(name: String, featured: String, file: String) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            let param = self.getCustomerParam(name: name, featured: featured, file: file)
            self.apiServices?.createBrand(finalURL: "\(Constants.Common.finalURL)/api/create_brand", httpHeaders: [String:String](), withParameters: param, completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                
                DispatchQueue.main.async {
                    if status == true {
                        self.successModel = result as? CreateCustomerModel
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
    
    func editBrand(name: String, featured: String, file: String) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            let param = self.getEditCustomerParam(name: name, featured: featured, file: file)
            self.apiServices?.editBrand(finalURL: "\(Constants.Common.finalURL)/api/edit_brand", httpHeaders: [String:String](), withParameters: param, completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                self.model = nil
                DispatchQueue.main.async {
                    if status == true {
                        self.successModel = result as? CreateCustomerModel
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
    
    func uploadProfilePic(name: String, featured: String) {
        let imageRequest = ImageRequestParam(paramName: "image", name: "image", image: self.selectedImage ?? UIImage())
        let otherParam = ["name": "\(name)",
                          "featured": "\(featured)"]
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            self.apiServices?.uploadProfileApi(finalURL: "\(Constants.Common.finalURL)/api/create_brand", withParameters: imageRequest, otherParameters: otherParam, completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                DispatchQueue.main.async {
                    self.hideLoadingIndicatorClosure?()
                    self.updateView?()
                }
            })
        } else {
            self.alertClosure?("Check your internet")
        }
    }
    
    func getCustomerParam(name: String, featured: String, file: String) ->String {
    let jsonToReturn: NSDictionary = ["name": "\(name)",
                                      "featured": "\(featured)", "file": "\(file)"
    ]
    return self.convertDictionaryToJsonString(dict: jsonToReturn)!
    }
    
    func getEditCustomerParam(name: String, featured: String, file: String) ->String {
    let jsonToReturn: NSDictionary = ["name": "\(name)",
                                      "featured": "\(featured)", "file": "\(file)", "id": "\(self.model?.id ?? 0)"
    ]
    return self.convertDictionaryToJsonString(dict: jsonToReturn)!
    }
}
