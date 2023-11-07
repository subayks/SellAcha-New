//
//  CreateOrderVC.swift
//  SellAcha
//
//  Created by apple on 25/10/23.
//

import UIKit

class CreateOrderVC: UIViewController {
    
    @IBOutlet weak var cellOverView: UIView!
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var orderSearchBar: UISearchBar!
    @IBOutlet weak var createOrderTB: UITableView!
    
    
    var vm = CreateOrderVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        self.vm.createShow()
        
        let containerView = UIView()
        containerView.frame = CGRect(x: 20, y: 120, width: view.bounds.width - 40, height: 40)
        let color = UIColor(hexString: "#ECECEC")
        containerView.backgroundColor = color
        view.addSubview(containerView)
        
        // Create the "Product" label
        let productLabel = UILabel()
        productLabel.text = "PRODUCT"
        productLabel.sizeToFit()
        productLabel.frame.origin = CGPoint(x: 20, y: 5)
        containerView.addSubview(productLabel)
        
        // Create the "SKU" label
        let skuLabel = UILabel()
        skuLabel.text = "PRICE"
        skuLabel.sizeToFit()
        skuLabel.frame.origin = CGPoint(x: productLabel.frame.maxX + 60, y: 5)
        containerView.addSubview(skuLabel)
        
        // Create the "Stock Manage" label
        let stockManageLabel = UILabel()
        stockManageLabel.text = "Cart"
        stockManageLabel.sizeToFit()
        stockManageLabel.frame.origin = CGPoint(x: skuLabel.frame.maxX + 100, y: 5)
        containerView.addSubview(stockManageLabel)
        // Set it as the table view's header view
        createOrderTB.tableHeaderView = containerView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
                self.createOrderTB.reloadData()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        overView.roundCorners(corners: [.topLeft , .topRight], radius: 30)
        cellOverView.roundCorners(corners: [.topLeft , .topRight], radius: 30)
    }
    
    
    
    @IBAction func checkoutAction(_ sender: Any) {
        let CreateOrderBillingVC = self.storyboard?.instantiateViewController(withIdentifier: "CreateBillingVC") as! CreateBillingVC
        self.navigationController?.pushViewController(CreateOrderBillingVC, animated: true)
    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
extension CreateOrderVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.model?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CreateOrderCell", for: indexPath) as! CreateOrderCell
        cell.cartAddBtn.addTarget(self, action: #selector(CreateOrderVC.oneTapped(_:)), for: .touchUpInside)
        cell.vm = self.vm.getBagTableViewCellVM(index: indexPath.row)
        return cell
    }
    
    @objc func oneTapped(_ sender: Any?) {
        print("Tapped")
    }
}

extension CreateOrderVC: UISearchBarDelegate {
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
        self.orderSearchBar.endEditing(true)
    }
}


extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}
