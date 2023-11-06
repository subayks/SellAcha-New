//
//  GeneralView.swift
//  SellAcha
//
//  Created by Subaykala on 19/10/23.
//

import UIKit

class GeneralView: UIViewController {
    
    @IBOutlet weak var currencyPositionTableView: UITableView!
    @IBOutlet weak var shopTypeTableView: UITableView!
    @IBOutlet weak var receiveMethodTableView: UITableView!
    @IBOutlet weak var storenameLabel: UILabel!
    @IBOutlet weak var storenameTextField: UITextField!
    @IBOutlet weak var storedescriptionLabel: UILabel!
    @IBOutlet weak var storedescriptionTextField: UITextField!
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var orderidLabel: UILabel!
    @IBOutlet weak var sho1TextField: UITextField!
    @IBOutlet weak var currencyPositionLabel: UILabel!
    @IBOutlet weak var leftTextField: UITextField!
    @IBOutlet weak var currencyNameLabel: UILabel!
    @IBOutlet weak var inrTextField: UITextField!
    @IBOutlet weak var currencyiconLabel: UILabel!
    @IBOutlet weak var currencyTextField: UITextField!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var taxTextField: UITextField!
    @IBOutlet weak var shopTypeLabel: UILabel!
    @IBOutlet weak var shopTypeTextField: UITextField!
    @IBOutlet weak var shopOrderLabel: UILabel!
    @IBOutlet weak var shopOrderTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var formScreenScrollView: UIScrollView!

    var vm = GeneralViewVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
        self.saveButton.layer.cornerRadius = 10
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        self.currencyPositionTableView.isHidden = true
        self.shopTypeTableView.isHidden = true
        self.receiveMethodTableView.isHidden = true
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
        
        self.vm.navigationClosure = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                formScreenScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        formScreenScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    @IBAction func actionSave(_ sender: Any) {
        if storenameTextField.text != "" && storedescriptionTextField.text != "" && self.emailTextField.text != "" && sho1TextField.text != "" && leftTextField.text != "" && inrTextField.text != "" && currencyTextField.text != "" && taxTextField.text != "" &&
            shopTypeTextField.text != "" && shopOrderTextField.text != "" {
            if !self.vm.isValidEmail(self.emailTextField.text ?? "") {
                let alert = UIAlertController(title: "Alert", message: "Please enter Valid Email", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            self.vm.createGeneral(type: "general", shopName: self.storenameTextField.text ?? "", shopDescription: self.storedescriptionTextField.text ?? "", storeEmail: self.emailTextField.text ?? "", orderPrefix: self.shopOrderTextField.text ?? "", currencyPosition: self.leftTextField.text ?? "", currencyName: self.inrTextField.text ?? "", currencyIcon: self.currencyTextField.text ?? "")
        } else {
            let alert = UIAlertController(title: "Alert", message: "Please fill all mandatory fields", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func actionCurrencyPosition(_ sender: Any) {
        self.currencyPositionTableView.isHidden = false
    }
    
    @IBAction func actionShopType(_ sender: Any) {
        self.shopTypeTableView.isHidden = false
    }
    
    @IBAction func actionReceiveMethod(_ sender: Any) {
        self.receiveMethodTableView.isHidden = false
    }
}

extension GeneralView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == currencyPositionTableView {
            return self.vm.currencyPosition.count
        } else if tableView == shopTypeTableView {
            return self.vm.shopType.count
        } else if tableView == receiveMethodTableView {
            return self.vm.receivePaymentMethod.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == currencyPositionTableView {
            let cell = currencyPositionTableView.dequeueReusableCell(withIdentifier: "MonthCell") as! MonthCell
            cell.textLabel?.text = self.vm.currencyPosition[indexPath.row]
            return cell
        } else if tableView == shopTypeTableView {
            let cell = shopTypeTableView.dequeueReusableCell(withIdentifier: "MonthCell") as! MonthCell
            cell.textLabel?.text = self.vm.shopType[indexPath.row]
            return cell
        } else if tableView == receiveMethodTableView {
            let cell = receiveMethodTableView.dequeueReusableCell(withIdentifier: "MonthCell") as! MonthCell
            cell.textLabel?.text = self.vm.receivePaymentMethod[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == currencyPositionTableView {
            self.currencyPositionTableView.isHidden = true
            self.leftTextField.text = self.vm.currencyPosition[indexPath.row]
        } else if tableView == shopTypeTableView {
            self.shopTypeTableView.isHidden = true
            self.shopTypeTextField.text = self.vm.shopType[indexPath.row]
        } else {
            self.receiveMethodTableView.isHidden = true
            self.shopOrderTextField.text = self.vm.receivePaymentMethod[indexPath.row]
        }
    }
    
}

