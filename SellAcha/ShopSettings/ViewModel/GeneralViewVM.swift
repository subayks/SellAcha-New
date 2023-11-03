//
//  GeneralViewVM.swift
//  SellAcha
//
//  Created by Subaykala on 19/10/23.
//

import Foundation

class GeneralViewVM: BaseViewModel {
    let currencyPosition = ["Left", "Right"]
    let shopType = ["I Will Sale physical product", "I Will Sale digital product"]
    let receivePaymentMethod = ["I Will Receive My Order Via WhatsApp", "I Will Receive My Order Via Email"]
    var apiServices: ShopSettingsServiceprotocol?
    var successModel: CreateCustomerModel?

    init(apiServices: ShopSettingsServiceprotocol = ShopSettingsService()) {
        self.apiServices = apiServices
    }
    
    func createLocation(type: String, address: String, city: String, state:String, zipCode:String,email:String,phone: String,invoiceDescription:String,companyName: String) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            

            self.apiServices?.createLocation(finalURL: "\(Constants.Common.finalURL)/api/theme_settings?type=\(type)&address=\(address)&city=\(city)&state=\(state)&zip_code=\(zipCode)&email=\(email)&phone=\(phone)&invoice_description=\(invoiceDescription)&company_name=\(companyName)", httpHeaders: [String:String](), withParameters: "", completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                
                DispatchQueue.main.async {
                    if status == true {
                        self.successModel = result as? CreateCustomerModel
                        self.navigationClosure?()
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
    
    func createGeneral(type: String, shopName: String, shopDescription:String, storeEmail:String,orderPrefix:String,currencyPosition:String,currencyName:String, currencyIcon: String) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()

            self.apiServices?.createGeneral(finalURL: "\(Constants.Common.finalURL)/api/theme_settings?type=\(type)&shop_name=\(shopName)&shop_description=\(shopDescription)&store_email=\(storeEmail)&order_prefix=\(orderPrefix)&currency_position=\(currencyPosition)&currency_name=\(currencyName)&currency_icon=\(currencyIcon)", httpHeaders: [String:String](), withParameters: "", completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                
                DispatchQueue.main.async {
                    if status == true {
                        self.successModel = result as? CreateCustomerModel
                        self.navigationClosure?()
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
