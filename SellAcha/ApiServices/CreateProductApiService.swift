//
//  CreateProductApiService.swift
//  SellAcha
//
//  Created by apple on 29/10/23.
//

import Foundation

import Foundation
protocol CreateProductApiServiceprotocol {
    func createProduct(finalURL: String, withParameters: ImageRequestParam,otherParameters: [String: String], completion: @escaping(_ status: Bool?, _ code: String?, _ response: AnyObject?, _ error: String?)-> Void)
}

class CreateProductApiService: CreateProductApiServiceprotocol {
    func createProduct(finalURL: String, withParameters: ImageRequestParam, otherParameters: [String : String], completion: @escaping (Bool?, String?, AnyObject?, String?) -> Void) {
        let headers = [
            "Authorization": "\(((UserDefaults.standard.string(forKey: "AuthToken") ?? "") as String))",
            ]
        NetworkAdapter.uploadImage(withBaseURL: finalURL, withParameters: withParameters, otherParameters: otherParameters, withHeaders: headers,  withHttpMethod: "POST", completionHandler: { (result: Data?, showPopUp: Bool?, error: String?, errorCode: String?)  -> Void in
            
            if let error = error {
                completion(false,errorCode,nil,error)
                
                return
            }
            
            DispatchQueue.main.async {
                
                do {
                    let decoder = JSONDecoder()
                    if result == nil {
                        completion(false,errorCode,nil,"Unhandled Error")
                        return
                    }
                    let values = try decoder.decode(CreateCustomerModel.self, from: result!)
                    
                    completion(true,errorCode,values as AnyObject?,error)
                    
                } catch let error as NSError {
                    //do something with error
                    completion(false,errorCode,nil,error.localizedDescription)
                }
            }
        })
    }
    
}

