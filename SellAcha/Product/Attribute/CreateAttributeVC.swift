//
//  CreateAttributeVC.swift
//  SellAcha
//
//  Created by apple on 23/10/23.
//

import UIKit

class CreateAttributeVC: UIViewController {
    @IBOutlet weak var overView: UIView!

    @IBOutlet weak var enterTitleTF: UITextField!
    @IBOutlet weak var enterStatus: UITextField!
    @IBOutlet weak var dropDownTable: UITableView!

    @IBOutlet weak var buttonSave: UIButton!
    var createAttributeVM = CreateAttributeVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.buttonSave.layer.cornerRadius = 10
        self.dropDownTable.isHidden = true
        
        if self.createAttributeVM.model != nil {
            self.enterTitleTF.text = self.createAttributeVM.model?.name
            if  self.createAttributeVM.model?.featured == 1 {
                self.enterStatus.text = "Yes"
            } else {
                self.enterStatus.text = "No"
            }
        } else {
            self.enterStatus.text = "Yes"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.createAttributeVM.errorClosure = { [weak self] (error) in
            DispatchQueue.main.async {
                guard let self = self else {return}
                if error != "" {
                    let alert = UIAlertController(title: "Alert", message: error, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
        self.createAttributeVM.alertClosure = { [weak self] (error) in
            DispatchQueue.main.async {
                guard let self = self else {return}
                let alert = UIAlertController(title: "Alert", message: error, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        self.createAttributeVM.showLoadingIndicatorClosure = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.showSpinner(onView: self.view)
            }
        }
        
        self.createAttributeVM.hideLoadingIndicatorClosure = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.removeSpinner()
            }
        }
        
        self.createAttributeVM.updateView = { [weak self] in
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
    
    @IBAction func actionDropDown(_ sender: Any) {
        self.dropDownTable.isHidden = false
    }
    
    @IBAction func actionCreate(_ sender: Any) {
        if self.enterTitleTF.text != "" {
            if self.createAttributeVM.model != nil {
                self.createAttributeVM.editAttributes(name: self.enterTitleTF.text ?? "", featured: self.enterStatus.text ?? "")
            } else {
                self.createAttributeVM.createAttributes(name: self.enterTitleTF.text ?? "", featured: self.enterStatus.text ?? "")
            }
        } else {
            let alert = UIAlertController(title: "Alert", message: "Please Enter Title", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension CreateAttributeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.createAttributeVM.status.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dropDownTable.dequeueReusableCell(withIdentifier: "MonthCell") as! MonthCell
        cell.textLabel?.text = self.createAttributeVM.status[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dropDownTable.isHidden = true
        self.enterStatus.text = self.createAttributeVM.status[indexPath.row]
    }
}
