//
//  MoreViewModel.swift
//  SellAcha
//
//  Created by Subaykala on 15/10/23.
//

import Foundation
struct MoreDataStructure {
    var itemName: String?
    var icon: String?
    var showRow: Bool = false
    var profileData: [ProfileData]?
}

class MoreViewModel {
    var profileData: [MoreDataStructure]?
    var previousIndex: Int?
    var dataStructure: [MoreDataStructure]?
    var reloadData: (()->())?
    
    func setupDataStructure(){
        var moreDataStructureArray = [MoreDataStructure]()
        //Products - 0
        var moreDataStructureProduct = MoreDataStructure()
        moreDataStructureProduct.itemName = "Products"
        moreDataStructureProduct.icon = "products"
        var profileDataArray = [ProfileData]()

        var profileData = ProfileData()
        profileData.name = "Inventory"
        profileDataArray.append(profileData)
        
        profileData.name = "Catrgories"
        profileDataArray.append(profileData)
        profileData.name = "Attributes"
        profileDataArray.append(profileData)
        profileData.name = "Brands"
        profileDataArray.append(profileData)
        profileData.name = "Coupons"
        profileDataArray.append(profileData)
        moreDataStructureProduct.profileData = profileDataArray
        moreDataStructureArray.append(moreDataStructureProduct)
        
        //Customer - 1
        var moreDataStructureCustomer = MoreDataStructure()
        moreDataStructureCustomer.itemName = "Customers"
        moreDataStructureCustomer.icon = "customer"
        moreDataStructureArray.append(moreDataStructureCustomer)

        //Transaction - 2
        var moreDataStructureTransactions = MoreDataStructure()
        moreDataStructureTransactions.itemName = "Transactions"
        moreDataStructureTransactions.icon = "transections"
        moreDataStructureArray.append(moreDataStructureTransactions)
        //Reports - 3
        var moreDataStructureReports = MoreDataStructure()
        moreDataStructureReports.itemName = "Reports"
        moreDataStructureReports.icon = "reports"
        moreDataStructureArray.append(moreDataStructureReports)
        //Review - 4
        var moreDataStructureReview = MoreDataStructure()
        moreDataStructureReview.itemName = "Review & Ratings"
        moreDataStructureReview.icon = "review_rating"
        moreDataStructureArray.append(moreDataStructureReview)
        //Shippping - 5
        var moreDataStructureShipping = MoreDataStructure()
        var profileDataArrayLocation = [ProfileData]()

        var profileDataLocation = ProfileData()
        profileDataLocation.name = "Location"
        profileDataArrayLocation.append(profileDataLocation)
        var profileDataPrice = ProfileData()
        profileDataPrice.name = "Shipping Price"
        profileDataArrayLocation.append(profileDataPrice)
        
        moreDataStructureShipping.itemName = "Shipping"
        moreDataStructureShipping.icon = "shipping"
        moreDataStructureShipping.profileData = profileDataArrayLocation
        moreDataStructureArray.append(moreDataStructureShipping)
        
        //Ads -6
        var moreDataStructureOffer = MoreDataStructure()
        var profileDataArrayOffer = [ProfileData]()

        var profileDataBump = ProfileData()
        profileDataBump.name = "Bump Ads"
        profileDataArrayOffer.append(profileDataBump)
        
        var profileDataBanner = ProfileData()
        profileDataBanner.name = "Banner Ads"
        profileDataArrayOffer.append(profileDataBanner)
        
        moreDataStructureOffer.itemName = "Offer & Ads"
        moreDataStructureOffer.icon = "marketingtools"
        moreDataStructureOffer.profileData = profileDataArrayOffer
        moreDataStructureArray.append(moreDataStructureOffer)
        
        //Settings - 7
        var moreDataStructureSettings = MoreDataStructure()
        var profileDataArraySettings = [ProfileData]()

        var profileDatapaymentOptions = ProfileData()
        profileDatapaymentOptions.name = "Payment Options"
        profileDataArraySettings.append(profileDatapaymentOptions)
        
        var profileDataSubscriptions = ProfileData()
        profileDataSubscriptions.name = "Subscriptions"
        profileDataArraySettings.append(profileDataSubscriptions)
        
        var profileDataDomain = ProfileData()
        profileDataDomain.name = "Domain Setting"
        profileDataArraySettings.append(profileDataDomain)
        
        var profileDataThemes = ProfileData()
        profileDataThemes.name = "Themes & Apk"
        profileDataArraySettings.append(profileDataThemes)
        
        moreDataStructureSettings.itemName = "Settings"
        moreDataStructureSettings.icon = "setting"
        moreDataStructureSettings.profileData = profileDataArraySettings
        moreDataStructureArray.append(moreDataStructureSettings)
        
        //Shop Settings - 8
        var moreDataStructureShop = MoreDataStructure()
        var profileDataArrayShop = [ProfileData]()

        var profileDataGeneral = ProfileData()
        profileDataGeneral.name = "General"
        profileDataArrayShop.append(profileDataGeneral)
        
        var profileDataLocationSettings = ProfileData()
        profileDataLocationSettings.name = "Location"
        profileDataArrayShop.append(profileDataLocationSettings)
        
        moreDataStructureShop.itemName = "Shop Settings"
        moreDataStructureShop.icon = "setting"
        moreDataStructureShop.profileData = profileDataArrayShop
        moreDataStructureArray.append(moreDataStructureShop)
        
        //Marketing Tools - 9
        var moreDataStructureMarketing = MoreDataStructure()
        var profileDataArrayMarketing = [ProfileData]()

        var profileDatapaymentAnalytics = ProfileData()
        profileDatapaymentAnalytics.name = "Google Analytics"
        profileDataArrayMarketing.append(profileDatapaymentAnalytics)
        
        var profileDataManager = ProfileData()
        profileDataManager.name = "Google Tap Manager"
        profileDataArrayMarketing.append(profileDataManager)
        
        var profileDataFacebook = ProfileData()
        profileDataFacebook.name = "Facebook Pixel"
        profileDataArrayMarketing.append(profileDataFacebook)
        
        var profileDataWhatsapp = ProfileData()
        profileDataWhatsapp.name = "Whatsapp Api"
        profileDataArrayMarketing.append(profileDataWhatsapp)
        
        moreDataStructureMarketing.itemName = "Marketing Tools"
        moreDataStructureMarketing.icon = "marketingtools"
        moreDataStructureMarketing.profileData = profileDataArrayMarketing
        moreDataStructureArray.append(moreDataStructureMarketing)
        
        //Upgrade
        var moreDataStructureUpgrade = MoreDataStructure()
        moreDataStructureUpgrade.itemName = "Upgrade your Plan"
        moreDataStructureUpgrade.icon = "settings"
        moreDataStructureArray.append(moreDataStructureUpgrade)
        
        //Customer Support
        var moreDataStructureSupport = MoreDataStructure()
        moreDataStructureSupport.itemName = "Customer Support"
        moreDataStructureSupport.icon = "customer support"
        moreDataStructureArray.append(moreDataStructureSupport)
        self.dataStructure = moreDataStructureArray
        self.reloadData?()
        }
    
    func getHeaderViewCellVM(section: Int) ->MoreViewCellVM {
        MoreViewCellVM(moreDataItem: self.dataStructure?[section] ?? MoreDataStructure())
    }
    
    func getProfileTableViewCellVM(indexPath: IndexPath) ->ProfileTableViewCellVM {
        ProfileTableViewCellVM(profileDataItem: self.dataStructure?[indexPath.section].profileData?[indexPath.row] ?? ProfileData())
    }
}
