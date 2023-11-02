//
//  ProfileViewModel.swift
//  SellAcha
//
//  Created by Subaykala on 15/10/23.
//

import Foundation

struct ProfileData {
    var name: String?
    var image: String?
}

class ProfileViewModel: BaseViewModel {
    var apiServices: ProfileServicesProtocol?
    var model: CreateCustomerModel?
    
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
}
