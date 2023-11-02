//
//  CustomerServices.swift
//  SellAcha
//
//  Created by Subaykala on 22/10/23.
//

import Foundation
protocol CustomerServicesProtocol {
    func postCustomer(finalURL: String, httpHeaders: [String: String], withParameters: String, completion: @escaping(_ status: Bool?, _ code: String?, _ response: AnyObject?, _ error: String?)-> Void)
    func getCustomer(finalURL: String, httpHeaders: [String: String], withParameters: String, completion: @escaping(_ status: Bool?, _ code: String?, _ response: AnyObject?, _ error: String?)-> Void)
    func filterCustomer(finalURL: String, httpHeaders: [String: String], withParameters: String, completion: @escaping(_ status: Bool?, _ code: String?, _ response: AnyObject?, _ error: String?)-> Void)
    func deleteCustomer(finalURL: String, httpHeaders: [String: String], withParameters: String, completion: @escaping(_ status: Bool?, _ code: String?, _ response: AnyObject?, _ error: String?)-> Void)
    func editCustomer(finalURL: String, httpHeaders: [String: String], withParameters: String, completion: @escaping(_ status: Bool?, _ code: String?, _ response: AnyObject?, _ error: String?)-> Void)
}

class CustomerServices: CustomerServicesProtocol {
    func deleteCustomer(finalURL: String, httpHeaders: [String : String], withParameters: String, completion: @escaping (Bool?, String?, AnyObject?, String?) -> Void) {
        let headers = [
            "Authorization": "\(((UserDefaults.standard.string(forKey: "AuthToken") ?? "") as String))",
            ]
        NetworkAdapter.clientNetworkRequestCodable(withBaseURL: finalURL, withParameters: withParameters, withHttpMethod: "POST", withContentType: "Application/json", withHeaders: headers, completionHandler: { (result: Data?, showPopUp: Bool?, error: String?, errorCode: String?)  -> Void in
            
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
        }
        )
    }
    
    func editCustomer(finalURL: String, httpHeaders: [String : String], withParameters: String, completion: @escaping (Bool?, String?, AnyObject?, String?) -> Void) {
        let headers = [
            "Authorization": "\(((UserDefaults.standard.string(forKey: "AuthToken") ?? "") as String))",
            ]
        NetworkAdapter.clientNetworkRequestCodable(withBaseURL: finalURL, withParameters: withParameters, withHttpMethod: "POST", withContentType: "Application/json", withHeaders: headers, completionHandler: { (result: Data?, showPopUp: Bool?, error: String?, errorCode: String?)  -> Void in
            
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
        }
        )
    }
    
    func filterCustomer(finalURL: String, httpHeaders: [String : String], withParameters: String, completion: @escaping (Bool?, String?, AnyObject?, String?) -> Void) {
        let headers = [
            "Authorization": "\(((UserDefaults.standard.string(forKey: "AuthToken") ?? "") as String))",
            ]
        NetworkAdapter.clientNetworkRequestCodable(withBaseURL: finalURL, withParameters: withParameters, withHttpMethod: "GET", withContentType: "Application/json", withHeaders: headers, completionHandler: { (result: Data?, showPopUp: Bool?, error: String?, errorCode: String?)  -> Void in
            
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
                    let values = try decoder.decode(BaseResponse<CustomerModel>.self, from: result!)
                    completion(true,errorCode,values as AnyObject?,error)
                } catch let error as NSError {
                    //do something with error
                    completion(false,errorCode,nil,error.localizedDescription)
                }
            }
        }
        )
    }
    
    func getCustomer(finalURL: String, httpHeaders: [String : String], withParameters: String, completion: @escaping (Bool?, String?, AnyObject?, String?) -> Void) {
        let headers = [
            "Authorization": "\(((UserDefaults.standard.string(forKey: "AuthToken") ?? "") as String))",
            ]
        NetworkAdapter.clientNetworkRequestCodable(withBaseURL: finalURL, withParameters: "", withHttpMethod: "GET", withContentType: "Application/json", withHeaders: headers, completionHandler: { (result: Data?, showPopUp: Bool?, error: String?, errorCode: String?)  -> Void in
            
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
                    let values = try decoder.decode(BaseResponse<CustomerModel>.self, from: result!)
                    completion(true,errorCode,values as AnyObject?,error)
                } catch let error as NSError {
                    //do something with error
                    completion(false,errorCode,nil,error.localizedDescription)
                }
                
            }
        }
        )
    }
    
    func postCustomer(finalURL: String, httpHeaders: [String : String], withParameters: String, completion: @escaping (Bool?, String?, AnyObject?, String?) -> Void) {
        let headers = [
            "Authorization": "\(((UserDefaults.standard.string(forKey: "AuthToken") ?? "") as String))",
            ]
        NetworkAdapter.clientNetworkRequestCodable(withBaseURL: finalURL, withParameters: withParameters, withHttpMethod: "POST", withContentType: "Application/json", withHeaders: headers, completionHandler: { (result: Data?, showPopUp: Bool?, error: String?, errorCode: String?)  -> Void in
            
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
        }
        )
    }
    
}
