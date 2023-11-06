//
//  CreateCustomerVc.swift
//  SellAcha
//
//  Created by Subaykala on 21/10/23.
//

import UIKit

class CreateCustomerVc: UIViewController {
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailIdLabel: UILabel!
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var emailIdField: UITextField!
    @IBOutlet weak var buttonCreate: UIButton!
    @IBOutlet weak var formScreenScrollView: UIScrollView!

    var vm = CustomerVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        buttonCreate.layer.cornerRadius = 10
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        if self.vm.customerModel != nil {
            self.userNameField.text = self.vm.customerModel?.name
            self.emailIdField.text = self.vm.customerModel?.email
        }
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
        
        self.vm.updateView = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //overView.roundCorners(corners: [.topLeft , .topRight], radius: 30)
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
    
    @IBAction func actionCreate(_ sender: Any) {
        if emailIdField.text != "" && userNameField.text != "" && passwordField.text != "" {
            if !self.vm.isValidEmail(emailIdField.text ?? "") {
                let alert = UIAlertController(title: "Alert", message: "Enter Valid Email", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            if passwordField.text?.count ?? 0 < 6 {
                let alert = UIAlertController(title: "Alert", message: "Enter more than 6 char in Password field", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            if self.vm.customerModel != nil {
                self.vm.editCustomer(email: emailIdField.text ?? "", name: userNameField.text ?? "", password: passwordField.text ?? "")
            } else {
                self.vm.postCustomer(email: emailIdField.text ?? "", name: userNameField.text ?? "", password: passwordField.text ?? "")
            }
        } else {
            let alert = UIAlertController(title: "Alert", message: "Please Fill All Mandatory Fields", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
