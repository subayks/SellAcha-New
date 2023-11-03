//
//  UserDetailsVC.swift
//  SellAcha
//
//  Created by Subaykala on 28/10/23.
//

import UIKit

class UserDetailsVC: UIViewController {
    
    @IBOutlet weak var userScrollView: UIScrollView!
    @IBOutlet weak var oveView: UIView!
    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    var updateProfileInfo:(()->())?

    var vm = UserDetailsVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.emailTextField.text = self.vm.model?.email ?? ""
        self.nameTextField.text = self.vm.model?.name ?? ""
        self.mobileNumberTextField.text = self.vm.model?.mob ?? ""
        
        if self.vm.isFromSettings {
            self.buttonSave.isHidden = false
            self.navigationController?.title = "Profile Settings"
        } else {
            self.buttonSave.isHidden = true
        }
        self.buttonSave.layer.cornerRadius = 15
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
                self.emailTextField.text = self.vm.model?.email ?? ""
                self.nameTextField.text = self.vm.model?.name ?? ""
                self.mobileNumberTextField.text = self.vm.model?.mob ?? ""
            }
        }
        
        self.vm.navigationClosure = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                if self.vm.isFromSettings {
                    self.updateProfileInfo?()
                }
                self.dismiss(animated: true)
            }
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        oveView.roundCorners(corners: [.topLeft , .topRight], radius: 30)
    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func actionSave(_ sender: Any) {
        if  self.emailTextField.text != "" &&  self.nameTextField.text != "" && self.mobileNumberTextField.text != "" {
            if  !self.vm.isValidEmail( self.emailTextField.text ?? "") {
                let alert = UIAlertController(title: "Alert", message: "Please Enter valid Email", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            self.vm.updateProfile(name:  self.nameTextField.text ?? "", email:  self.emailTextField.text ?? "", mob: self.mobileNumberTextField.text ?? "")
        }
    }
}
