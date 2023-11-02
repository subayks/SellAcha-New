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
        
        
        let containerView = UIView()
        containerView.frame = CGRect(x: 20, y: 100, width: view.bounds.width - 40, height: 40)
        containerView.backgroundColor = UIColor.systemGray5
        view.addSubview(containerView)
        
        // Create the "Product" label
        let productLabel = UILabel()
        productLabel.text = "Images"
        productLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        productLabel.sizeToFit()
        productLabel.frame.origin = CGPoint(x: 20, y: 5)
        containerView.addSubview(productLabel)
        
        // Create the "SKU" label
        let skuLabel = UILabel()
        skuLabel.text = "Names"
        skuLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        skuLabel.sizeToFit()
        skuLabel.frame.origin = CGPoint(x: productLabel.frame.maxX + 30, y: 5)
        containerView.addSubview(skuLabel)
        
        // Create the "Stock Manage" label
        let stockManageLabel = UILabel()
        stockManageLabel.text = "Delete"
        stockManageLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        stockManageLabel.sizeToFit()
        stockManageLabel.frame.origin = CGPoint(x: skuLabel.frame.maxX + 40, y: 5)
        containerView.addSubview(stockManageLabel)
        
        let EditLabel = UILabel()
        EditLabel.text = "Edit"
        EditLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        EditLabel.sizeToFit()
        EditLabel.frame.origin = CGPoint(x: stockManageLabel.frame.maxX + 50, y: 5)
        containerView.addSubview(EditLabel)
        
        // Set it as the table view's header view
        categoriesTB.tableHeaderView = containerView
        
        // Do any additional setup after loading the view.
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
        self.navigationController?.pushViewController(createCategoriesVC, animated: true)
    }
    
    @IBAction func actionDelete(_ sender: UIButton) {
       // self.vm.deleteAttributes(index: sender.tag)
    }
}

extension CategoriesVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in your table view
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Return the appropriate UITableViewCell for your data
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesCell", for: indexPath)  as! CategoriesCell
        cell.deleteBtn.tag = indexPath.row
        cell.editBtn.tag = indexPath.row
        return cell
    }
}
