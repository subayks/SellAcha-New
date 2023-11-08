//
//  CategoriesVC.swift
//  SellAcha
//
//  Created by apple on 18/10/23.
//

import UIKit

class CategoriesVC: UIViewController {
    
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var searchField: UISearchBar!
    @IBOutlet weak var categoriesTB: UITableView!
    var vm = CategoriesVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        categoriesTB.delegate = self
        categoriesTB.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.vm.getCategories()
        
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
    
    @IBAction func createCategoryAction(_ sender: Any) {
        let createCategoriesVC = self.storyboard?.instantiateViewController(withIdentifier: "CreateCategoriesVC") as! CreateCategoriesVC
        self.navigationController?.pushViewController(createCategoriesVC, animated: true)
    }
    
    @IBAction func actionEdit(_ sender: UIButton) {
        let createCategoriesVC = self.storyboard?.instantiateViewController(withIdentifier: "CreateCategoriesVC") as! CreateCategoriesVC
        createCategoriesVC.vm = self.vm.getCustomerVM(index: sender.tag)
        self.navigationController?.pushViewController(createCategoriesVC, animated: true)
    }
    
    @IBAction func actionDelete(_ sender: UIButton) {
        self.vm.deleteCategories(index: sender.tag)
    }
}

extension CategoriesVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in your table view
        return self.vm.model?.count == 0 ? 1: self.vm.model?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerHeaderCell") as! CustomerHeaderCell
        cell.backgroundColor = UIColor.systemGray6
        return cell
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesCell", for: indexPath)  as! CategoriesCell
            cell.vm = self.vm.getCategoriesCellVM(index: indexPath.row)
           cell.deleteBtn.tag = indexPath.row
           cell.editBtn.tag = indexPath.row
           return cell
        }
    }
}
extension CategoriesVC: UISearchBarDelegate {
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
