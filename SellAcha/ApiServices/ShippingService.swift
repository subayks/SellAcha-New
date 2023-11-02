//
//  ShippingService.swift
//  SellAcha
//
//  Created by Subaykala on 25/10/23.
//

import Foundation
protocol ShippingServiceProtocol {
    func getLocation(finalURL: String, httpHeaders: [String: String], withParameters: String, completion: @escaping(_ status: Bool?, _ code: String?, _ response: AnyObject?, _ error: String?)-> Void)
    func createLocation(finalURL: String, httpHeaders: [String: String], withParameters: String, completion: @escaping(_ status: Bool?, _ code: String?, _ response: AnyObject?, _ error: String?)-> Void)
    func editLocation(finalURL: String, httpHeaders: [String: String], withParameters: String, completion: @escaping(_ status: Bool?, _ code: String?, _ response: AnyObject?, _ error: String?)-> Void)
    func deleteLocation(finalURL: String, httpHeaders: [String: String], withParameters: String, completion: @escaping(_ status: Bool?, _ code: String?, _ response: AnyObject?, _ error: String?)-> Void)
   
    func getShipping(finalURL: String, httpHeaders: [String: String], withParameters: String, completion: @escaping(_ status: Bool?, _ code: String?, _ response: AnyObject?, _ error: String?)-> Void)
    func createShipping(finalURL: String, httpHeaders: [String: String], withParameters: String, completion: @escaping(_ status: Bool?, _ code: String?, _ response: AnyObject?, _ error: String?)-> Void)
    func editShipping(finalURL: String, httpHeaders: [String: String], withParameters: String, completion: @escaping(_ status: Bool?, _ code: String?, _ response: AnyObject?, _ error: String?)-> Void)
    func deleteShipping(finalURL: String, httpHeaders: [String: String], withParameters: String, completion: @escaping(_ status: Bool?, _ code: String?, _ response: AnyObject?, _ error: String?)-> Void)
   
}

class ShippingService: ShippingServiceProtocol {
    func getLocation(finalURL: String, httpHeaders: [String : String], withParameters: String, completion: @escaping (Bool?, String?, AnyObject?, String?) -> Void) {
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
                    let values = try decoder.decode(BaseResponse<LocationModel>.self, from: result!)
                    completion(true,errorCode,values as AnyObject?,error)
                } catch let error as NSError {
                    //do something with error
                    completion(false,errorCode,nil,error.localizedDescription)
                }
                
            }
        }
        )
    }
    
    func createLocation(finalURL: String, httpHeaders: [String : String], withParameters: String, completion: @escaping (Bool?, String?, AnyObject?, String?) -> Void) {
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
    
    func editLocation(finalURL: String, httpHeaders: [String : String], withParameters: String, completion: @escaping (Bool?, String?, AnyObject?, String?) -> Void) {
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
    
    func deleteLocation(finalURL: String, httpHeaders: [String : String], withParameters: String, completion: @escaping (Bool?, String?, AnyObject?, String?) -> Void) {
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
    
    func getShipping(finalURL: String, httpHeaders: [String : String], withParameters: String, completion: @escaping (Bool?, String?, AnyObject?, String?) -> Void) {
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
                    let values = try decoder.decode(BaseResponse<ShippingModel>.self, from: result!)
                    completion(true,errorCode,values as AnyObject?,error)
                } catch let error as NSError {
                    //do something with error
                    completion(false,errorCode,nil,error.localizedDescription)
                }
                
            }
        }
        )
    }
    
    func createShipping(finalURL: String, httpHeaders: [String : String], withParameters: String, completion: @escaping (Bool?, String?, AnyObject?, String?) -> Void) {
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
    
    func editShipping(finalURL: String, httpHeaders: [String : String], withParameters: String, completion: @escaping (Bool?, String?, AnyObject?, String?) -> Void) {
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
    
    func deleteShipping(finalURL: String, httpHeaders: [String : String], withParameters: String, completion: @escaping (Bool?, String?, AnyObject?, String?) -> Void) {
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
