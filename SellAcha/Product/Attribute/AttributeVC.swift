//
//  AttributeVC.swift
//  SellAcha
//
//  Created by apple on 18/10/23.
//

import UIKit

class AttributeVC: UIViewController {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var attributeSearchTextField: UISearchBar!
    @IBOutlet weak var attributeTB: UITableView!
    var attributeVM = AttributeVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        attributeTB.delegate = self
        attributeTB.dataSource = self
        
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
        skuLabel.text = "VARIATIONS"
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
        
        
        
        attributeTB.tableHeaderView = containerView
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.attributeVM.getAttributes()
        
        self.attributeVM.errorClosure = { [weak self] (error) in
            DispatchQueue.main.async {
                guard let self = self else {return}
                if error != "" {
                    let alert = UIAlertController(title: "Alert", message: error, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
        self.attributeVM.alertClosure = { [weak self] (error) in
            DispatchQueue.main.async {
                guard let self = self else {return}
                let alert = UIAlertController(title: "Alert", message: error, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        self.attributeVM.showLoadingIndicatorClosure = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.showSpinner(onView: self.view)
            }
        }
        
        self.attributeVM.hideLoadingIndicatorClosure = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.removeSpinner()
            }
        }
        
        self.attributeVM.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.attributeTB.reloadData()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        overView.roundCorners(corners: [.topLeft , .topRight], radius: 30)
    }
    
    @IBAction func createAttributeAction(_ sender: Any) {
        let createAttributeVC = self.storyboard?.instantiateViewController(withIdentifier: "CreateAttributeVC") as! CreateAttributeVC
        self.navigationController?.pushViewController(createAttributeVC, animated: true)
    }
    
    @IBAction func deleteBrand(_ sender: UIButton) {
        self.attributeVM.deleteAttributes(index: sender.tag)
    }
    
    @IBAction func editBrand(_ sender: UIButton) {
        let createAttributeVC = self.storyboard?.instantiateViewController(withIdentifier: "CreateAttributeVC") as! CreateAttributeVC
        createAttributeVC.createAttributeVM = self.attributeVM.getCustomerVM(index: sender.tag)
        self.navigationController?.pushViewController(createAttributeVC, animated: true)
    }
}

extension AttributeVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in your table view
        return self.attributeVM.model?.count == 0 ? 1: self.attributeVM.model?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.attributeVM.model?.count == nil {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MonthCell") as! MonthCell
            cell.textLabel?.text = ""
            return cell
        }
        if self.attributeVM.model?.count == 0  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MonthCell") as! MonthCell
            cell.textLabel?.text = "No Records Found"
            return cell
        } else {
            // Return the appropriate UITableViewCell for your data
            let cell = tableView.dequeueReusableCell(withIdentifier: "AttributeCell", for: indexPath) as! AttributeCell
            cell.attributeCellVM = self.attributeVM.getCustomerCellVM(index: indexPath.row)
            cell.deleteBtn.tag = indexPath.row
            cell.editBtn.tag = indexPath.row
            return cell
        }
    }
}

extension AttributeVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange,
                   replacementText text: String) -> Bool {
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let keyword = searchBar.text{
            self.attributeVM.sorting(keyword: keyword)
        }
        self.attributeSearchTextField.endEditing(true)
    }
}
