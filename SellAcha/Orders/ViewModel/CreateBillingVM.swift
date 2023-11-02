//
//  CreateBillingVM.swift
//  SellAcha
//
//  Created by Subaykala on 29/10/23.
//

import Foundation
class CreateBillingVM: BaseViewModel {
    var apiServices: OrdersServiceProtocol?
    var model: OrdersModel?
    var successModel :CreateCustomerModel?
    var status: String?
    var payment: String?
    
    init(apiServices: OrdersServiceProtocol = OrdersService()) {
        self.apiServices = apiServices
    }
    
    func redeemCoupon(coupon: String) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            let param = self.getCustomerParam(code: coupon)
            self.apiServices?.applyCoupon(finalURL: "\(Constants.Common.finalURL)/api/apply_coupon", httpHeaders: [String:String](), withParameters: param, completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                self.model = nil
                DispatchQueue.main.async {
                    if status == true {
                        self.successModel = result as? CreateCustomerModel
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
    
    func createOrder(customerType: String, deliverType: String, shippingMethod: String, paymentId: String, name: String, email: String, phone: String, address: String, zipCode: String, location: String, comment: String) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            let param = self.getOrderParam(customerType: customerType, deliverType: deliverType, shippingMethod: shippingMethod, paymentId: paymentId, name: name, email: email, phone: phone, address: address, zipCode: zipCode, location: location, comment: comment)
            self.apiServices?.applyCoupon(finalURL: "\(Constants.Common.finalURL)/api/make_order", httpHeaders: [String:String](), withParameters: param, completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                self.model = nil
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
    
    func getCustomerParam(code: String) ->String {
        let jsonToReturn: NSDictionary = ["code": "\(code)"]
    return self.convertDictionaryToJsonString(dict: jsonToReturn)!
    }
    
    func getOrderParam(customerType: String, deliverType: String, shippingMethod: String, paymentId: String, name: String, email: String, phone: String, address: String, zipCode: String, location: String, comment: String) ->String {
        let jsonToReturn: NSDictionary = ["customer_type": "\(customerType)", "delivery_type": "\(deliverType)", "shipping_method": "\(shippingMethod)", "payment_id": "\(paymentId)", "payment_method": "\(payment ?? "")", "payment_status": "\(status ?? "")", "name": "\(name)", "email": "\(email)", "phone": "\(phone)", "address": "\(address)", "zip_code": "\(zipCode)", "location": "\(location)", "comment": "\(comment)"]
    return self.convertDictionaryToJsonString(dict: jsonToReturn)!
    }
}
