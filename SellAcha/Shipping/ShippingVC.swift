//
//  ShippingVC.swift
//  SellAcha
//
//  Created by apple on 23/10/23.
//

import UIKit

class ShippingVC: UIViewController {
    @IBOutlet weak var overView: UIView!

    @IBOutlet weak var shippingSearchBar: UISearchBar!
    @IBOutlet weak var locationTableView: UITableView!
    var vm = ShippingVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.vm.getShipping()
        
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
                self.locationTableView.reloadData()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        overView.roundCorners(corners: [.topLeft , .topRight], radius: 30)
    }
    
    @IBAction func actionDelete(_ sender: UIButton) {
        self.vm.deleteShipping(index: sender.tag)
    }
    
    @IBAction func actionEdit(_ sender: UIButton) {
        let createShippingVC = self.storyboard?.instantiateViewController(withIdentifier: "CreateShippingVC") as! CreateShippingVC
        createShippingVC.vm = self.vm.getCustomerVM(index: sender.tag)
        self.navigationController?.pushViewController(createShippingVC, animated: true)
    }
    
    @IBAction func createLocationAction(_ sender: Any) {
        let createShippingVC = self.storyboard?.instantiateViewController(withIdentifier: "CreateShippingVC") as! CreateShippingVC
        self.navigationController?.pushViewController(createShippingVC, animated: true)
    }
}

extension ShippingVC: UITableViewDelegate,UITableViewDataSource {
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "ShippingCell", for: indexPath) as! ShippingCell
            cell.vm = self.vm.getCustomerCellVM(index: indexPath.row)
            cell.buttonDelete.tag = indexPath.row
            cell.buttonEdit.tag = indexPath.row
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerHeaderCell") as! CustomerHeaderCell
        return cell
    }
}

extension ShippingVC: UISearchBarDelegate {
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
        self.shippingSearchBar.endEditing(true)
    }
}
