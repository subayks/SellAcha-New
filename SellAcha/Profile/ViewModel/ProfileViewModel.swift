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
    var profileModel: ProfileModel?
    var userDetailsModel: UserDetailsModel?
    
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
    
    func getProfileImage() {
        if Reachability.isConnectedToNetwork() {
          //  self.showLoadingIndicatorClosure?()
            
            self.apiServices?.getProileImage(finalURL: "\(Constants.Common.finalURL)/api/logos", withParameters: "", completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()

                DispatchQueue.main.async {
                    if status == true {
                        let array = result as? BaseResponse<ProfileModel>
                        self.profileModel = array?.data
                        self.updateProfileImage?()
                        UserDefaults.standard.save(customObject: self.profileModel!, inKey: "Profile")
                    } else{
                        self.alertClosure?(errorMessage ?? "Some Technical Problem")
                    }
                }
            })
        }
        else {
            self.alertClosure?("No Internet Availabe")
        }
    }
    
    func getUserDetails() {
        if Reachability.isConnectedToNetwork() {
        //    self.showLoadingIndicatorClosure?()
            
            self.apiServices?.getUserDetails(finalURL: "\(Constants.Common.finalURL)/api/me", withParameters: "", completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()

                DispatchQueue.main.async {
                    if status == true {
                        let array = result as? BaseResponse<UserDetailsModel>
                        self.userDetailsModel = array?.data
                        UserDefaults.standard.save(customObject: self.userDetailsModel!, inKey: "UserDetails")
                        self.updateView?()
                    } else{
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
        UserDetailsVM(model: self.retriveUserDetails()!, isFromSettings: isFromSettings)
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
extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }

    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
}
