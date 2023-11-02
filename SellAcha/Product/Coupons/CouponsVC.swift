//
//  CouponsVC.swift
//  SellAcha
//
//  Created by apple on 18/10/23.
//

import UIKit

class CouponsVC: UIViewController {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var couponsTB: UITableView!
    @IBOutlet weak var searchField: UISearchBar!

    var vm = CouponsVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
                
        couponsTB.delegate = self
        couponsTB.dataSource = self
        
        // Create the "Product" label
        let containerView = UIView()
        containerView.frame = CGRect(x: 20, y: 100, width: view.bounds.width - 40, height: 40)
        containerView.backgroundColor = UIColor.systemGray5
        view.addSubview(containerView)
        
        // Create the "Product" label
        let productLabel = UILabel()
        productLabel.text = "Name"
        productLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        productLabel.sizeToFit()
        productLabel.frame.origin = CGPoint(x: 20, y: 5)
        containerView.addSubview(productLabel)
        
        // Create the "SKU" label
        let skuLabel = UILabel()
        skuLabel.text = "Expired Date"
        skuLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        skuLabel.sizeToFit()
        skuLabel.frame.origin = CGPoint(x: productLabel.frame.maxX + 20, y: 5)
        containerView.addSubview(skuLabel)
        
        // Create the "Stock Manage" label
        let stockManageLabel = UILabel()
        stockManageLabel.text = "Delete"
        stockManageLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        stockManageLabel.sizeToFit()
        stockManageLabel.frame.origin = CGPoint(x: skuLabel.frame.maxX + 20, y: 5)
        containerView.addSubview(stockManageLabel)
        
        let EditLabel = UILabel()
        EditLabel.text = "Edit"
        EditLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        EditLabel.sizeToFit()
        EditLabel.frame.origin = CGPoint(x: stockManageLabel.frame.maxX + 40, y: 5)
        containerView.addSubview(EditLabel)
        
        
        
        couponsTB.tableHeaderView = containerView
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func createCouponsAction(_ sender: Any) {
        let CreateCouponsVC = self.storyboard?.instantiateViewController(withIdentifier: "CreateCouponsVC") as! CreateCouponsVC
        self.navigationController?.pushViewController(CreateCouponsVC, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.vm.getCoupons()
        
        self.vm.errorClosure = { [weak self] (error) in
            DispatchQueue.main.async {
                guard let self = self else {return}
                if error != "" {
                    let alert = UIAlertController(title: "Alert", message: error, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
        self.vm.alertClosure = { [weak self] (error) in
            DispatchQueue.main.async {
                guard let self = self else {return}
                let alert = UIAlertController(title: "Alert", message: error, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        self.vm.showLoadingIndicatorClosure = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.showSpinner(onView: self.view)
            }
        }
        
        self.vm.hideLoadingIndicatorClosure = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.removeSpinner()
            }
        }
        
        self.vm.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.couponsTB.reloadData()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        overView.roundCorners(corners: [.topLeft , .topRight], radius: 30)
    }
    
    @IBAction func actionEdit(_ sender: UIButton) {
        let createBrandsVC = self.storyboard?.instantiateViewController(withIdentifier: "CreateCouponsVC") as! CreateCouponsVC
        createBrandsVC.createCouponsVM = self.vm.getCustomerVM(index: sender.tag)
        self.navigationController?.pushViewController(createBrandsVC, animated: true)
    }
    
    @IBAction func actionDelete(_ sender: UIButton) {
        self.vm.deleteCoupons(index: sender.tag)
    }
    
}


extension CouponsVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // Return the number of rows in your table view
            return self.vm.model?.count == 0 ? 1: self.vm.model?.count ?? 1
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if self.vm.model?.count == nil {
                let cell = tableView.dequeueReusableCell(withIdentifier: "MonthCell") as! MonthCell
                cell.textLabel?.text = ""
                return cell
            }
            
            if self.vm.model?.count == 0  {
                let cell = tableView.dequeueReusableCell(withIdentifier: "MonthCell") as! MonthCell
                cell.textLabel?.text = "No Records Found"
                return cell
            } else {
                // Return the appropriate UITableViewCell for your data
                let cell = tableView.dequeueReusableCell(withIdentifier: "CouponsCell", for: indexPath) as! CouponsCell

                cell.couponsCellVM = self.vm.getCustomerCellVM(index: indexPath.row)
                cell.buttonEdit.tag = indexPath.row
                cell.buttonDelete.tag = indexPath.row
                return cell
            }
            
        }
}
extension CouponsVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange,
                   replacementText text: String) -> Bool {
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let keyword = searchBar.text{
            self.vm.sorting(keyword: keyword)
        }
        self.searchField.endEditing(true)
    }
}
