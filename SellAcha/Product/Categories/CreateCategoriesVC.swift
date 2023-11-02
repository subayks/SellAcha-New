//
//  CreateCategoriesVC.swift
//  SellAcha
//
//  Created by apple on 23/10/23.
//

import UIKit

class CreateCategoriesVC: UIViewController {
    
    @IBOutlet weak var enterName: UITextField!
    @IBOutlet weak var chooseFileBtn: UIButton!
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var assignToField: UITextField!
    @IBOutlet weak var featuredField: UITextField!
    @IBOutlet weak var serviceField: UITextField!
    
        // declare Array in pickerview.
    
    let servicesArray = ["Product","Service","Both"]
    let featuredArray = ["Yes","No","Both"]
    let assignToMenuArray = ["Yes","No","Both"]
    
     // declare pickerviews.
    
    var servicePickerView = UIPickerView()
    var featuredPickerView = UIPickerView()
    var assignMenuPickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        // textfield input to pickerview.
        serviceField.inputView = servicePickerView
        featuredField.inputView = featuredPickerView
        assignToField.inputView = assignMenuPickerView
        
        // adding delegates to pickerview.
        servicePickerView.delegate = self
        servicePickerView.dataSource = self
        featuredPickerView.delegate = self
        featuredPickerView.dataSource = self
        assignMenuPickerView.delegate = self
        assignMenuPickerView.dataSource = self
        
        // adding tag to pickerview
        servicePickerView.tag = 1
        featuredPickerView.tag = 2
        assignMenuPickerView.tag = 3
        // Do any additional setup after loading the view.
        
        // adding tint color
        
        serviceField.tintColor = UIColor.black
        assignToField.tintColor = UIColor.black
        featuredField.tintColor = UIColor.black
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        overView.roundCorners(corners: [.topLeft , .topRight], radius: 30)
    }
    
    @IBAction func actionChoosePic(_ sender: Any) {
      //  self.createBrandsVM.requestPhotoAccess()
    }
    
    @IBAction func saveAction(_ sender: Any) {
        
    }
}


extension CreateCategoriesVC: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return servicesArray.count
        case 2:
            return featuredArray.count
        case 3:
            return assignToMenuArray.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return servicesArray[row]
        case 2:
            return featuredArray[row]
        case 3:
            return assignToMenuArray[row]
        default:
            return "Data not found"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            serviceField.text = servicesArray[row]
            serviceField.resignFirstResponder()
        case 2:
            featuredField.text = featuredArray[row]
            featuredField.resignFirstResponder()
        case 3:
            assignToField.text = assignToMenuArray[row]
            assignToField.resignFirstResponder()
        default:
            return
        }
    }
    
    
}
