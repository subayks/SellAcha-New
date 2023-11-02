//
//  ProfileViewModel.swift
//  SellAcha
//
//  Created by Subaykala on 15/10/23.
//

import Foundation
import UIKit

struct ProfileData {
    var name: String?
    var image: String?
}

class ProfileViewModel: BaseViewModel {
    var apiServices: ProfileServicesProtocol?
    var model: CreateCustomerModel?
    var selectedImage: UIImage? {
        didSet {
            self.updateProfile()
        }
    }
    
    let title = ["User Details", "Profile Settings", "Change Password", "Logout"]
    let image = ["UserDetails", "profilesetting", "changepassword", "logout"]
    var profileData: [ProfileData]?
    
    init(apiServices: ProfileServicesProtocol = ProfileServices()) {
        self.apiServices = apiServices
    }
    
    func getLogOut() {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            
            self.apiServices?.getLogOut(finalURL: "\(Constants.Common.finalURL)/api/logout", httpHeaders: [String:String](), withParameters: "", completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                
                DispatchQueue.main.async {
                    if status == true {
                        self.model = result as? CreateCustomerModel
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
    
    func updateProfile() {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            let imageRequest = ImageRequestParam(paramName: "logo", name: "logo", image: self.selectedImage ?? UIImage())
            self.apiServices?.updateProfileLogo(finalURL: "\(Constants.Common.finalURL)/api/profile", httpHeaders: [String:String](), withParameters: imageRequest, completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                
                DispatchQueue.main.async {
                    if status == true {
                        self.model = result as? CreateCustomerModel
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
    
    func setupDataStructure() ->[ProfileData] {
        var profileDataArray = [ProfileData]()
        
        for (index, item) in title.enumerated() {
            var profileDataItem = ProfileData()
            profileDataItem.image = image[index]
            profileDataItem.name = item
            profileDataArray.append(profileDataItem)
        }
        self.profileData = profileDataArray
        return profileDataArray
    }
    
    func getProfileTableViewCellVM(index: Int) ->ProfileTableViewCellVM {
        ProfileTableViewCellVM(profileDataItem: self.setupDataStructure()[index])
    }
    
    func getUserDetailsVM(isFromSettings: Bool) ->UserDetailsVM {
        UserDetailsVM(isFromSettings: isFromSettings)
    }
    
    func retriveProfile() ->ProfileModel?{
        let obj = UserDefaults.standard.retrieve(object: ProfileModel.self, fromKey: "Profile")
        return obj
    }
    
    func retriveUserDetails() ->UserDetailsModel?{
        let obj = UserDefaults.standard.retrieve(object: UserDetailsModel.self, fromKey: "UserDetails")
        return obj
    }
    
    
}
extension UserDefaults {
    
    func save<T:Encodable>(customObject object: T, inKey key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(object) {
            self.set(encoded, forKey: key)
        }
    }
    
    func retrieve<T:Decodable>(object type:T.Type, fromKey key: String) -> T? {
        if let data = self.data(forKey: key) {
            let decoder = JSONDecoder()
            if let object = try? decoder.decode(type, from: data) {
                return object
            }else {
                print("Couldnt decode object")
                return nil
            }
        }else {
            print("Couldnt find key")
            return nil
        }
    }
    
}
