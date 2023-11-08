//
//  BrandsVC.swift
//  SellAcha
//
//  Created by apple on 18/10/23.
//

import UIKit

class BrandsVC: UIViewController {
    @IBOutlet weak var overView: UIView!

    @IBOutlet weak var searchField: UISearchBar!
    @IBOutlet weak var brandsTB: UITableView!
    let brandsVM = BrandsVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        brandsTB.delegate = self
        brandsTB.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.brandsVM.getBrand()

        self.brandsVM.errorClosure = { [weak self] (error) in
            DispatchQueue.main.async {
                guard let self = self else {return}
                if error != "" {
                    let alert = UIAlertController(title: "Alert", message: error, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
        self.brandsVM.alertClosure = { [weak self] (error) in
            DispatchQueue.main.async {
                guard let self = self else {return}
                let alert = UIAlertController(title: "Alert", message: error, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        self.brandsVM.showLoadingIndicatorClosure = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.showSpinner(onView: self.view)
            }
        }
        
        self.brandsVM.hideLoadingIndicatorClosure = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.removeSpinner()
            }
        }
        
        self.brandsVM.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.brandsTB.reloadData()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        overView.roundCorners(corners: [.topLeft , .topRight], radius: 30)
    }
    
    @IBAction func deleteBrand(_ sender: UIButton) {
        self.brandsVM.deleteCustomer(index: sender.tag)
    }
    
    @IBAction func editBrand(_ sender: UIButton) {
        let createBrandsVC = self.storyboard?.instantiateViewController(withIdentifier: "CreateBrandsVC") as! CreateBrandsVC
        createBrandsVC.createBrandsVM = self.brandsVM.getCustomerVM(index: sender.tag)
        self.navigationController?.pushViewController(createBrandsVC, animated: true)
    }
    
    @IBAction func createBrandsAction(_ sender: Any) {
        let createBrandsVC = self.storyboard?.instantiateViewController(withIdentifier: "CreateBrandsVC") as! CreateBrandsVC
        self.navigationController?.pushViewController(createBrandsVC, animated: true)
    }
}

extension BrandsVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in your table view
        return self.brandsVM.model?.count == 0 ? 1: self.brandsVM.model?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerHeaderCell") as! CustomerHeaderCell
        cell.backgroundColor = UIColor.systemGray6
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.brandsVM.model?.count == nil {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MonthCell") as! MonthCell
            cell.textLabel?.text = ""
            return cell
        }
        if self.brandsVM.model?.count == 0  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MonthCell") as! MonthCell
            cell.textLabel?.text = "No Records Found"
            return cell
        } else {
            // Return the appropriate UITableViewCell for your data
            let cell = tableView.dequeueReusableCell(withIdentifier: "BrandsCell", for: indexPath) as! BrandsCell
            cell.vm = self.brandsVM.getCustomerCellVM(index: indexPath.row)
            cell.buttonDelete.tag = indexPath.row
            cell.editButton.tag = indexPath.row
            return cell
        }
    }
}
extension BrandsVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange,
                   replacementText text: String) -> Bool {
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let keyword = searchBar.text{
            self.brandsVM.sorting(keyword: keyword)
        }
        self.searchField.endEditing(true)
    }
}
