//
//  SignupViewModel.swift
//  SellAcha
//
//  Created by Subaykala on 05/11/23.
//

import Foundation
class SignupViewModel: BaseViewModel {
    var apiServices: LoginApiServiceprotocol?
    var model: ReportsModel?
    
    init(apiServices: LoginApiServiceprotocol = LoginApiService()) {
        self.apiServices = apiServices
    }
    
    func makeSignUp(email: String, password: String, sertype: String, refrral: String, mob: String, themeColor: String, pId: String, featured: String,menuStatus: String, price: String,astatus: String,gfile: String,tstatus: String,pstatus: String, wstatus: String, name: String, domain: String, customDomain: String,utype: String,businessName: String, shopType:String, cname: String,title: String, specialPriceStart: String, specialPrice: String, priceType: String, type: String,specialPriceEnd: String, gaMeasurementId: String, analyticsViewId: String, tagId: String, pixelId: String, number: String, shopPagePretext: String, otherPagePretext: String, plnt: String) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()

            self.apiServices?.makeSignUp(finalURL: "\(Constants.Common.finalURL)/api/seller_register/1?password=\(password)&sertype=\(sertype)&refrral=\(refrral)&mob=\(mob)&theme_color=\(themeColor)&p_id=\(pId)&featured=\(featured)&menu_status=\(menuStatus)&price=\(price)&astatus=\(astatus)&gfile=\(gfile)&tstatus=\(tstatus)&pstatus=\(pstatus)&wstatus=\(wstatus)&name=\(name)&email=\(email)&domain=\(domain)&custom_domain=\(customDomain)&utype=\(utype)&business_name=\(businessName)&shop_type=\(shopType)&cname=\(cname)&title=\(title)&special_price_start=\(specialPriceStart)&special_price=\(specialPrice)&price_type=\(priceType)&type=\(type)&special_price_end=\(specialPriceEnd)&ga_measurement_id=\(gaMeasurementId)&analytics_view_id=\(analyticsViewId)&tag_id=\(tagId)&pixel_id=\(pixelId)&number=\(number)&shop_page_pretext=\(shopPagePretext)&other_page_pretext=\(otherPagePretext)&refrral=\(refrral)&plnt=\(plnt)", httpHeaders: [String:String](), withParameters: "", completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                DispatchQueue.main.async {
                    self.hideLoadingIndicatorClosure?()
                    if status == true {
                     //   let model  = result as? BaseResponse<LoginModel>
                    //    self.loginModel = model?.data
                        
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
