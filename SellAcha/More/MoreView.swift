//
//  MoreView.swift
//  SellAcha
//
//  Created by Subaykala on 15/10/23.
//

import UIKit

class MoreView: UIViewController {

    @IBOutlet weak var moreTableView: UITableView!
    let vm = MoreViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.vm.setupDataStructure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.vm.reloadData = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.moreTableView.reloadData()
            }
        }
    }
    
    @IBAction func actionTouch(_ sender: UIButton) {
        
        if self.vm.getHeaderViewCellVM(section: sender.tag).moreDataItem?.itemName ==  "Customers" {
            let customerVc = self.storyboard?.instantiateViewController(withIdentifier: "CustomerVc") as! CustomerVc
            self.navigationController?.pushViewController(customerVc, animated: true)
            return
        }
        
        if self.vm.getHeaderViewCellVM(section: sender.tag).moreDataItem?.itemName == "Transactions" {
            let customerVc = self.storyboard?.instantiateViewController(withIdentifier: "TransactionVC") as! TransactionVC
            self.navigationController?.pushViewController(customerVc, animated: true)
            return
        }
        
        if self.vm.getHeaderViewCellVM(section: sender.tag).moreDataItem?.itemName == "Reports" {
            let customerVc = self.storyboard?.instantiateViewController(withIdentifier: "ReportsVC") as! ReportsVC
            self.navigationController?.pushViewController(customerVc, animated: true)
            return
        }
        
        if self.vm.getHeaderViewCellVM(section: sender.tag).moreDataItem?.itemName == "Review & Ratings" {
            let customerVc = self.storyboard?.instantiateViewController(withIdentifier: "RatingVc") as! RatingVc
            self.navigationController?.pushViewController(customerVc, animated: true)
            return
        }
        
        if self.vm.getHeaderViewCellVM(section: sender.tag).moreDataItem?.itemName ==  "Customer Support"  {
            let chatNowVC = self.storyboard?.instantiateViewController(withIdentifier: "ChatNowVC") as! ChatNowVC
            self.navigationController?.pushViewController(chatNowVC, animated: true)
            return
        }
        
        if sender.tag != self.vm.previousIndex {
            //Hide previous
            if self.vm.previousIndex != nil {
                self.vm.dataStructure?[self.vm.previousIndex ?? 0].showRow = false
            }
            //Show
            self.vm.previousIndex = sender.tag
            self.vm.dataStructure?[sender.tag].showRow = true
            self.moreTableView.reloadData()
        } else {
            //Hide
            if self.vm.previousIndex != nil {
                self.vm.dataStructure?[self.vm.previousIndex ?? 0].showRow = false
            }
            self.vm.previousIndex = nil
            self.moreTableView.reloadData()
        }
    }
}

extension MoreView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.vm.dataStructure?[section].showRow == true {
            return self.vm.dataStructure?[section].profileData?.count ?? 0
        } else {
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.vm.dataStructure?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = moreTableView.dequeueReusableCell(withIdentifier: "MoreViewCell") as! MoreViewCell
        cell.vm = self.vm.getHeaderViewCellVM(section: section)
        cell.buttonTouch.tag = section
        cell.accessoryView?.isHidden = false
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moreTableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell") as! ProfileTableViewCell
        cell.accessoryType = .disclosureIndicator
        cell.profileTableViewCellVM = self.vm.getProfileTableViewCellVM(indexPath: indexPath)
        cell.accessoryView?.isHidden = false
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.vm.getHeaderViewCellVM(section: indexPath.section).moreDataItem?.itemName == "Products" {
            if self.vm.getHeaderViewCellVM(section: indexPath.section).moreDataItem?.profileData?[indexPath.row].name
                == "Inventory"
            {
                let inventory = self.storyboard?.instantiateViewController(withIdentifier: "InventoryVC") as! InventoryVC
                self.navigationController?.pushViewController(inventory, animated: true)
            }
            
            else if self.vm.getHeaderViewCellVM(section: indexPath.section).moreDataItem?.profileData?[indexPath.row].name == "Catrgories"
            {
            let catrgories = self.storyboard?.instantiateViewController(withIdentifier: "CategoriesVC") as! CategoriesVC
            self.navigationController?.pushViewController(catrgories, animated: true)
            }
            
            else if self.vm.getHeaderViewCellVM(section: indexPath.section).moreDataItem?.profileData?[indexPath.row].name == "Attributes"
            {
            let attributes = self.storyboard?.instantiateViewController(withIdentifier: "AttributeVC") as! AttributeVC
            self.navigationController?.pushViewController(attributes, animated: true)
            }
            
            else if self.vm.getHeaderViewCellVM(section: indexPath.section).moreDataItem?.profileData?[indexPath.row].name == "Brands"
            {
            let brands = self.storyboard?.instantiateViewController(withIdentifier: "BrandsVC") as! BrandsVC
            self.navigationController?.pushViewController(brands, animated: true)
            }
            
            else if self.vm.getHeaderViewCellVM(section: indexPath.section).moreDataItem?.profileData?[indexPath.row].name == "Coupons"
            {
            let coupons = self.storyboard?.instantiateViewController(withIdentifier: "CouponsVC") as! CouponsVC
            self.navigationController?.pushViewController(coupons, animated: true)
            }
            
        } else if  self.vm.getHeaderViewCellVM(section: indexPath.section).moreDataItem?.itemName ==  "Marketing Tools" {
            if self.vm.getHeaderViewCellVM(section: indexPath.section).moreDataItem?.profileData?[indexPath.row].name == "Google Analytics" {
                let googleAnalytics = self.storyboard?.instantiateViewController(withIdentifier: "GoogleAnalytics") as! GoogleAnalytics
                self.navigationController?.pushViewController(googleAnalytics, animated: true)
            } else if self.vm.getHeaderViewCellVM(section: indexPath.section).moreDataItem?.profileData?[indexPath.row].name == "Google Tap Manager" {
                let googleTapManager = self.storyboard?.instantiateViewController(withIdentifier: "GoogleTapManager") as! GoogleTapManager
                self.navigationController?.pushViewController(googleTapManager, animated: true)
            } else if self.vm.getHeaderViewCellVM(section: indexPath.section).moreDataItem?.profileData?[indexPath.row].name == "Facebook Pixel" {
                let faceBookApi = self.storyboard?.instantiateViewController(withIdentifier: "FaceBookApi") as! FaceBookApi
                self.navigationController?.pushViewController(faceBookApi, animated: true)
            } else if self.vm.getHeaderViewCellVM(section: indexPath.section).moreDataItem?.profileData?[indexPath.row].name == "Whatsapp Api" {
                let whatsAppApi = self.storyboard?.instantiateViewController(withIdentifier: "WhatsAppApi") as! WhatsAppApi
                self.navigationController?.pushViewController(whatsAppApi, animated: true)
            }
        } else if  self.vm.getHeaderViewCellVM(section: indexPath.section).moreDataItem?.itemName ==  "Shop Settings" {
            
            if self.vm.getHeaderViewCellVM(section: indexPath.section).moreDataItem?.profileData?[indexPath.row].name == "General" {
                let whatsAppApi = self.storyboard?.instantiateViewController(withIdentifier: "GeneralView") as! GeneralView
                self.navigationController?.pushViewController(whatsAppApi, animated: true)
                
            } else if self.vm.getHeaderViewCellVM(section: indexPath.section).moreDataItem?.profileData?[indexPath.row].name == "Location" {
                let whatsAppApi = self.storyboard?.instantiateViewController(withIdentifier: "LocationView") as! LocationView
                self.navigationController?.pushViewController(whatsAppApi, animated: true)
            }
        }
        
        else if  self.vm.getHeaderViewCellVM(section: indexPath.section).moreDataItem?.itemName ==  "Shipping" {
            
            if self.vm.getHeaderViewCellVM(section: indexPath.section).moreDataItem?.profileData?[indexPath.row].name == "Location" {
                let locationVC = self.storyboard?.instantiateViewController(withIdentifier: "LocationVC") as! LocationVC
                self.navigationController?.pushViewController(locationVC, animated: true)
                
            } else if self.vm.getHeaderViewCellVM(section: indexPath.section).moreDataItem?.profileData?[indexPath.row].name == "Shipping Price" {
                let shippingVC = self.storyboard?.instantiateViewController(withIdentifier: "ShippingVC") as! ShippingVC
                self.navigationController?.pushViewController(shippingVC, animated: true)
            }
        } else if  self.vm.getHeaderViewCellVM(section: indexPath.section).moreDataItem?.itemName ==  "Offer & Ads" {
            
            if self.vm.getHeaderViewCellVM(section: indexPath.section).moreDataItem?.profileData?[indexPath.row].name == "Bump Ads" {
                let bumperAdsVC = self.storyboard?.instantiateViewController(withIdentifier: "BumperAdsVC") as! BumperAdsVC
                self.navigationController?.pushViewController(bumperAdsVC, animated: true)
                
            } else if self.vm.getHeaderViewCellVM(section: indexPath.section).moreDataItem?.profileData?[indexPath.row].name == "Banner Ads" {
                let bannerAdsVC = self.storyboard?.instantiateViewController(withIdentifier: "BannerAdsVC") as! BannerAdsVC
                self.navigationController?.pushViewController(bannerAdsVC, animated: true)
            }
        } else if  self.vm.getHeaderViewCellVM(section: indexPath.section).moreDataItem?.itemName ==  "Settings" {
            if self.vm.getHeaderViewCellVM(section: indexPath.section).moreDataItem?.profileData?[indexPath.row].name == "Domain Setting" {
                let domainVC = self.storyboard?.instantiateViewController(withIdentifier: "DomainVC") as! DomainVC
                self.navigationController?.pushViewController(domainVC, animated: true)
                
            } else if self.vm.getHeaderViewCellVM(section: indexPath.section).moreDataItem?.profileData?[indexPath.row].name == "Subscriptions" {
                let domainVC = self.storyboard?.instantiateViewController(withIdentifier: "SubscriptionVC") as! SubscriptionVC
                self.navigationController?.pushViewController(domainVC, animated: true)
                
            }
        }
        
    }
}
