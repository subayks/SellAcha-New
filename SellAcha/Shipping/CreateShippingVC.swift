//
//  CreateShippingVC.swift
//  SellAcha
//
//  Created by apple on 23/10/23.
//

import UIKit

class CreateShippingVC: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var textFieldLocation: UITextField!
    @IBOutlet weak var textFieldPrice: UITextField!
    @IBOutlet weak var actionSave: UIButton!
    var vm = CreateShippingVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        // Do any additional setup after loading the view.
        
        self.titleTextField.underlined(color: UIColor.lightGray)
        self.textFieldLocation.underlined(color: UIColor.lightGray)
        self.textFieldPrice.underlined(color: UIColor.lightGray)
        if self.vm.model != nil {
            self.titleTextField.text = self.vm.model?.name
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
        overView.roundCorners(corners: [.topLeft , .topRight], radius: 30)
    }
    
    @IBAction func actionCreate(_ sender: Any) {
        if self.titleTextField.text != "" && self.textFieldPrice.text != "" && textFieldLocation != nil {
            if self.vm.model != nil {
                self.vm.editShipping(title: titleTextField.text ?? "", price: self.textFieldPrice.text ?? "", location: [0])
            } else {
                self.vm.createLocation(title: titleTextField.text ?? "", price: self.textFieldPrice.text ?? "", location: [0])
            }
        } else {
            let alert = UIAlertController(title: "Alert", message: "Please fill All the Fields", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
