//
//  WhatsAppApi.swift
//  SellAcha
//
//  Created by Subaykala on 19/10/23.
//

import UIKit

class WhatsAppApi: UIViewController {
    @IBOutlet weak var selectionTableView: UITableView!
    @IBOutlet weak var buttonStatus: UIButton!
    @IBOutlet weak var statusFieldValue: UITextField!
    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var NumberField: UITextField!
    @IBOutlet weak var pageNameField: UITextField!
    @IBOutlet weak var productNameField: UITextField!
    let vm = WhatsAppApiVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        self.buttonSave.layer.cornerRadius = 10
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
//        self.NumberField.addBottomBorder()
//        self.pageNameField.addBottomBorder()
//        self.productNameField.addBottomBorder()

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
    
    @IBAction func actionStatus(_ sender: Any) {
        self.selectionTableView.isHidden = false
    }
    
    @IBAction func actionSave(_ sender: Any) {
        if self.NumberField.text != "" && self.statusFieldValue.text  != "" && self.productNameField.text != "" && self.pageNameField.text != "" {
            self.vm.postWhatsApp(type: "whatsapp", number: self.NumberField.text ?? "", status: self.statusFieldValue.text ?? "", shopPagePretext: self.productNameField.text ?? "", otherPagePretext: self.pageNameField.text ?? "")
        } else {
            let alert = UIAlertController(title: "Alert", message: "Please fill all mandatory fields", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension WhatsAppApi: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.status.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = selectionTableView.dequeueReusableCell(withIdentifier: "MonthCell") as! MonthCell
        cell.textLabel?.text = self.vm.status[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectionTableView.isHidden = true
        self.statusFieldValue.text = self.vm.status[indexPath.row]
    }
}
