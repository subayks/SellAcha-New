//
//  CustomerVc.swift
//  SellAcha
//
//  Created by Subaykala on 21/10/23.
//

import UIKit

class CustomerVc: UIViewController {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var customerSearchBar: UISearchBar!
    @IBOutlet weak var categoriesTB: UITableView!
    let vm = CustomerListVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesTB.delegate = self
        categoriesTB.dataSource = self
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    @IBAction func actionCreateCustomer(_ sender: Any) {
        let createCustomerVc = self.storyboard?.instantiateViewController(withIdentifier: "CreateCustomerVc") as! CreateCustomerVc
        self.navigationController?.pushViewController(createCustomerVc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.vm.getCustomer()

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
                self.categoriesTB.reloadData()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        overView.roundCorners(corners: [.topLeft , .topRight], radius: 30)
    }
    
    @IBAction func actionEdit(_ sender: UIButton) {
        let createCustomerVc = self.storyboard?.instantiateViewController(withIdentifier: "CreateCustomerVc") as! CreateCustomerVc
        createCustomerVc.vm = self.vm.getCustomerVM(index: sender.tag)
        self.navigationController?.pushViewController(createCustomerVc, animated: true)
    }
    
    @IBAction func actionDelete(_ sender: UIButton) {
        self.vm.deleteCustomer(index: sender.tag)
    }
    
    
}

extension CustomerVc: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in your table view
        return self.vm.model?.posts?.data?.count == 0 ? 1: self.vm.model?.posts?.data?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerHeaderCell") as! CustomerHeaderCell
        cell.backgroundColor = UIColor.systemGray6
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Return the appropriate UITableViewCell for your data
        if self.vm.model?.posts?.data?.count == nil {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MonthCell") as! MonthCell
            cell.textLabel?.text = ""
            return cell
        }
        if self.vm.model?.posts?.data?.count == 0  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MonthCell") as! MonthCell
            cell.textLabel?.text = "No Records Found"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerCell") as! CustomerCell
            cell.editButton.tag = indexPath.row
            cell.delete.tag = indexPath.row
            cell.vm  = self.vm.getCustomerCellVM(index: indexPath.row)
            return cell
        }
    }
}

extension CustomerVc: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange,
                   replacementText text: String) -> Bool {
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let keyword = searchBar.text{
            if keyword == "" {
                self.vm.getCustomer()
            } else {
                self.vm.filterCustomer(keyword: keyword)
            }
        }
        self.customerSearchBar.endEditing(true)
    }
}
