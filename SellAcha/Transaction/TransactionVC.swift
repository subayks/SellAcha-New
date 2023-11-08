//
//  TransactionVC.swift
//  SellAcha
//
//  Created by Subaykala on 21/10/23.
//

import UIKit

class TransactionVC: UIViewController {

    @IBOutlet weak var searchTransaction: UISearchBar!
    @IBOutlet weak var transactionTableView: UITableView!
    @IBOutlet weak var overView: UIView!

     let vm = TransactionVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.vm.getTransactionList()
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
                self.transactionTableView.reloadData()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        overView.roundCorners(corners: [.topLeft , .topRight], radius: 30)
    }
}

extension TransactionVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.model?.orders?.data?.count  == 0 ? 1:self.vm.model?.orders?.data?.count ?? 1
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.vm.model?.orders?.data?.count == nil {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MonthCell") as! MonthCell
            cell.textLabel?.text = ""
            return cell
        }
        if self.vm.model?.orders?.data?.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MonthCell") as! MonthCell
            cell.textLabel?.text = "No Records Found"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell") as! TransactionCell
            cell.pendingButton.layer.cornerRadius = 5
            cell.transactionCellVM = self.vm.getTransactionCellVM(index: indexPath.row)
            return cell
        }
    }
}

extension TransactionVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange,
                   replacementText text: String) -> Bool {
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let keyword = searchBar.text{
            if keyword == "" {
                self.vm.getTransactionList()
            } else {
                self.vm.getTransactionbyID(keyword: keyword)
            }
        }
        self.searchTransaction.endEditing(true)
    }
}
