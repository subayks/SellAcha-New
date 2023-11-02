//
//  SignUpViewController.swift
//  SellAcha
//
//  Created by apple on 26/10/23.
//

import UIKit

class SignUpViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var GoogleAnalyticsViewIdTF: UITextField!
    @IBOutlet weak var GoogleMeasurIDTF: UITextField!
    @IBOutlet weak var GoogleSelectStatusTF: UITextField!
    @IBOutlet weak var addCategoryView: UIView!
    
    @IBOutlet weak var buttonOne: UIButton!
    
    @IBOutlet weak var buttonTwo: UIButton!
    
    @IBOutlet weak var buttonThree: UIButton!
    
    @IBOutlet weak var productPrice: UITextField!
    
    @IBOutlet weak var buttonFour: UIButton!
    
    @IBOutlet weak var BusinessNameTF: UITextField!
    
    @IBOutlet weak var mobileNumberTF: UITextField!
    
    @IBOutlet weak var ProductTypeTF: UITextField!
    
    @IBOutlet weak var RefeeralTF: UITextField!
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var confirmPasswordTF: UITextField!
    
    @IBOutlet weak var serviceTF: UITextField!
    
    @IBOutlet weak var StoreInfoView: UIView!
    
    @IBOutlet weak var radiBtnInstall: UIButton!
    
    @IBOutlet weak var radiBtnActive: UIButton!
    
    @IBOutlet weak var ThemeView: UIView!
    
    @IBOutlet weak var colorThemeView: UIView!
    
    let thePicker = UIPickerView()
    
    @IBOutlet weak var themeColorTF: UITextField!
    
    let theServicePicker = UIPickerView()
    
    @IBOutlet weak var logoIconImg: UIImageView!
    
    @IBOutlet weak var favIconImg: UIImageView!
    
    @IBOutlet weak var favIconSelectedLbl: UILabel!
    
    @IBOutlet weak var urlCountLbl: UILabel!
    
    @IBOutlet weak var productTitleTF: UITextField!
    @IBOutlet weak var logoSelectLbl: UILabel!
    
    let myPickerData = ["Product","Service","Both"]
    
    @IBOutlet weak var sellbettaLogoView: UIView!
    
    @IBOutlet weak var brandTF: UITextField!
    
    @IBOutlet weak var tagLineTF: UITextField!
    
    @IBOutlet weak var urlVieww: UIView!
    
    @IBOutlet weak var facebookTF: UITextField!
    
    @IBOutlet weak var facebookPixelTF: UITextField!
    
    @IBOutlet weak var facebookStatusTF: UITextField!
    
    let myPickerServiceData = ["Shoes","Health","Fruit","Vegetable","Clothing","Hand Bags","Hijab Wear","Purses","Cosmetics","Electronic"]
    
    let parentCategoryArray = ["None","Diary","Health","Fruit","Vegetable","Clothing","Hand Bags","Hijab Wear","Purses","Shoes","Cosmetics"]
    
    let featuredArray = ["Yes","No"]
    
    let AssignToArray = ["Yes","No"]
    
    let specialPriceArray = ["Fixed","Percentage"]
    
    let selectStatusArray = ["Enable","Disable"]
    
    let parentCategoryPicker = UIPickerView()
    
    let specialPricePicker = UIPickerView()
    
    let featuredPicker = UIPickerView()
    
    let assignPicker = UIPickerView()
    
    let selectStatusPicker = UIPickerView()
    
    let facebookStatusPicker = UIPickerView()
    
    let googleTabManagerStatusPicker = UIPickerView()
    
    let whatappickerView = UIPickerView()
    
    var incrementOrDecrementValue = 0
    
    @IBOutlet weak var IconClassTF: UITextField!
    
    @IBOutlet weak var selectCategoryTF: UITextField!
    
    @IBOutlet weak var whatsappStatusTF: UITextField!
    
    @IBOutlet weak var filechoosenLbl: UILabel!
    
    @IBOutlet weak var selectAssignToTF: UITextField!
    
    @IBOutlet weak var selectFeatureTFProduct: UITextField!
    
    
    @IBOutlet weak var AddProductView: UIView!
    
    
    @IBOutlet weak var product: UITextField!
    
    
    @IBOutlet weak var productPricestartsTF: UITextField!
    
    @IBOutlet weak var selectProductSpecialPriceTF: UITextField!
    
    @IBOutlet weak var productSpecialPrice: UITextField!
    
    @IBOutlet weak var productPriceEndsTF: UITextField!
    
    
    @IBOutlet weak var TabManagerSelectStatusTF: UITextField!
    
    
    @IBOutlet weak var whatsappVieww: UIView!
    
    @IBOutlet weak var facebookPixelView: UIView!
    
    @IBOutlet weak var TabManagerIDTF: UITextField!
    
    @IBOutlet weak var googleTagmanagerView: UIView!
    
    @IBOutlet weak var googleAnalyticsVieww: UIView!
    
    
    @IBOutlet weak var whatsappQueryTF: UITextField!
    
    @IBOutlet weak var whatsappPurchaseProductTF: UITextField!
    
    @IBOutlet weak var whatappNumberTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        self.ThemeView.isHidden = true
        self.StoreInfoView.isHidden = false
        self.sellbettaLogoView.isHidden = true
        self.colorThemeView.isHidden = true
        self.addCategoryView.isHidden = true
        self.AddProductView.isHidden = true
        self.googleAnalyticsVieww.isHidden = true
        self.googleTagmanagerView.isHidden = true
        self.whatsappVieww.isHidden = true
        self.facebookPixelView.isHidden = true
        self.navigationItem.setHidesBackButton(true, animated: false)
        buttonOne.clipsToBounds = true
        buttonOne.layer.cornerRadius = buttonOne.frame.size.width/2
        buttonTwo.clipsToBounds = true
        buttonTwo.layer.cornerRadius = buttonTwo.frame.size.width/2
        buttonThree.clipsToBounds = true
        buttonThree.layer.cornerRadius = buttonThree.frame.size.width/2
        buttonFour.clipsToBounds = true
        buttonFour.layer.cornerRadius = buttonFour.frame.size.width/2
        BusinessNameTF.tintColor = .black
        mobileNumberTF.tintColor = .black
        ProductTypeTF.tintColor = .black
        serviceTF.tintColor = .black
        ProductTypeTF.tintColor = .black
        RefeeralTF.tintColor = .black
        emailTF.tintColor = .black
        passwordTF.tintColor = .black
        confirmPasswordTF.tintColor = .black
        ProductTypeTF.inputView = thePicker
        thePicker.delegate = self
        ProductTypeTF.inputView = thePicker
        serviceTF.delegate = self
        theServicePicker.delegate = self
        serviceTF.inputView = theServicePicker
        ProductTypeTF.delegate = self
        serviceTF.delegate = self
        thePicker.tag = 1
        theServicePicker.tag = 2
        thePicker.delegate = self
        thePicker.dataSource = self
        theServicePicker.delegate = self
        theServicePicker.dataSource = self
        selectCategoryTF.inputView = parentCategoryPicker
        selectFeatureTFProduct.inputView = featuredPicker
        selectAssignToTF.inputView = assignPicker
        parentCategoryPicker.delegate = self
        parentCategoryPicker.dataSource = self
        featuredPicker.delegate = self
        featuredPicker.dataSource = self
        assignPicker.delegate = self
        assignPicker.dataSource = self
        parentCategoryPicker.tag = 3
        featuredPicker.tag = 4
        assignPicker.tag = 5
        specialPricePicker.tag = 6
        selectStatusPicker.tag = 7
        googleTabManagerStatusPicker.tag = 8
        facebookStatusPicker.tag = 9
        facebookStatusTF.inputView = facebookStatusPicker
        facebookStatusPicker.delegate = self
        facebookStatusPicker.dataSource = self
        TabManagerSelectStatusTF.inputView = googleTabManagerStatusPicker
        googleTabManagerStatusPicker.delegate = self
        googleTabManagerStatusPicker.dataSource = self
        selectProductSpecialPriceTF.inputView = specialPricePicker
        GoogleSelectStatusTF.inputView = selectStatusPicker
        selectStatusPicker.delegate = self
        selectStatusPicker.dataSource = self
        specialPricePicker.delegate = self
        specialPricePicker.dataSource = self
        //urlVieww.roundCorners(corners: [.topLeft , .topRight], radius: 30)
        whatappickerView.delegate = self
        whatappickerView.dataSource = self
        whatsappStatusTF.inputView = whatappickerView
        whatappickerView.tag = 10
    }
    
    @IBAction func saveBtnAction(_ sender: Any) {
        ThemeView.isHidden = false
        StoreInfoView.isHidden = true
        sellbettaLogoView.isHidden = true
        colorThemeView.isHidden = true
        self.addCategoryView.isHidden = true
        self.AddProductView.isHidden = true
        self.googleAnalyticsVieww.isHidden = true
        self.googleTagmanagerView.isHidden = true
        self.facebookPixelView.isHidden = true
        self.whatsappVieww.isHidden = true
    }
    
    @IBAction func installRadioBtnAction(_ sender: Any) {
        radiBtnInstall.setImage(UIImage(named: "radioOn"), for: .normal)
    }
    
    @IBAction func activeRadioButtonAction(_ sender: Any) {
        radiBtnActive.setImage(UIImage(named: "radioOn"), for: .normal)
    }
    
    @IBAction func chooseFileGalleryAction(_ sender: Any) {
    }
    
    @IBAction func themeSaveAction(_ sender: Any) {
        ThemeView.isHidden = true
        StoreInfoView.isHidden = true
        sellbettaLogoView.isHidden = false
        colorThemeView.isHidden = true
        self.addCategoryView.isHidden = true
        self.AddProductView.isHidden = true
        self.googleAnalyticsVieww.isHidden = true
        self.googleTagmanagerView.isHidden = true
        self.facebookPixelView.isHidden = true
        self.whatsappVieww.isHidden = true
    }
   
    @IBAction func sellbettaSavebtnAction(_ sender: Any) {
        ThemeView.isHidden = true
        StoreInfoView.isHidden = true
        sellbettaLogoView.isHidden = true
        colorThemeView.isHidden = false
        self.addCategoryView.isHidden = true
        self.AddProductView.isHidden = true
        self.googleAnalyticsVieww.isHidden = true
        self.googleTagmanagerView.isHidden = true
        self.facebookPixelView.isHidden = true
        self.whatsappVieww.isHidden = true
    }
    
    
    @IBAction func removeBtnAction(_ sender: Any) {
        if(incrementOrDecrementValue != 0){
               incrementOrDecrementValue -= 1;
           }
        self.urlCountLbl.text = "\(incrementOrDecrementValue)"
    }
    
    @IBAction func addNewBtnAction(_ sender: Any) {
        incrementOrDecrementValue += 1;
        self.urlCountLbl.text = "\(incrementOrDecrementValue)"
    }
    
    @IBAction func colorSaveBtnAction(_ sender: Any) {
        self.ThemeView.isHidden = true
        self.StoreInfoView.isHidden = true
        self.sellbettaLogoView.isHidden = true
        self.colorThemeView.isHidden = true
        self.addCategoryView.isHidden = false
        self.AddProductView.isHidden = true
        self.googleAnalyticsVieww.isHidden = true
        self.googleTagmanagerView.isHidden = true
        self.facebookPixelView.isHidden = true
        self.whatsappVieww.isHidden = true
    }
    
    @IBAction func cateogrySaveBtnAction(_ sender: Any) {
        self.ThemeView.isHidden = true
        self.StoreInfoView.isHidden = true
        self.sellbettaLogoView.isHidden = true
        self.colorThemeView.isHidden = true
        self.addCategoryView.isHidden = true
        self.AddProductView.isHidden = false
        self.googleAnalyticsVieww.isHidden = true
        self.googleTagmanagerView.isHidden = true
        self.facebookPixelView.isHidden = true
        self.whatsappVieww.isHidden = true
    }
    
    
    @IBAction func productSaveBtnAction(_ sender: Any) {
        self.ThemeView.isHidden = true
        self.StoreInfoView.isHidden = true
        self.sellbettaLogoView.isHidden = true
        self.colorThemeView.isHidden = true
        self.addCategoryView.isHidden = true
        self.AddProductView.isHidden = true
        self.googleAnalyticsVieww.isHidden = false
        self.googleTagmanagerView.isHidden = true
        self.facebookPixelView.isHidden = true
        self.whatsappVieww.isHidden = true
    }
    
    @IBAction func googleSkipBtnAction(_ sender: Any) {
        self.ThemeView.isHidden = true
        self.StoreInfoView.isHidden = true
        self.sellbettaLogoView.isHidden = true
        self.colorThemeView.isHidden = true
        self.addCategoryView.isHidden = true
        self.AddProductView.isHidden = false
        self.googleAnalyticsVieww.isHidden = true
        self.googleTagmanagerView.isHidden = true
        self.facebookPixelView.isHidden = true
        self.whatsappVieww.isHidden = true
    }
    
    
    @IBAction func googleChooseFileBtnAction(_ sender: Any) {
    }
    
    
    @IBAction func gooleSavebtnAction(_ sender: Any) {
        self.ThemeView.isHidden = true
        self.StoreInfoView.isHidden = true
        self.sellbettaLogoView.isHidden = true
        self.colorThemeView.isHidden = true
        self.addCategoryView.isHidden = true
        self.AddProductView.isHidden = true
        self.googleAnalyticsVieww.isHidden = true
        self.googleTagmanagerView.isHidden = false
        self.facebookPixelView.isHidden = true
        self.whatsappVieww.isHidden = true
    }
    
    
    @IBAction func TabManagerSkipBtn(_ sender: Any) {
        self.ThemeView.isHidden = true
        self.StoreInfoView.isHidden = true
        self.sellbettaLogoView.isHidden = true
        self.colorThemeView.isHidden = true
        self.addCategoryView.isHidden = true
        self.AddProductView.isHidden = true
        self.googleAnalyticsVieww.isHidden = true
        self.googleTagmanagerView.isHidden = true
        self.facebookPixelView.isHidden = false
        self.whatsappVieww.isHidden = true
    }
    
    
    
    @IBAction func tabManagerSaveBtnAction(_ sender: Any) {
        self.ThemeView.isHidden = true
        self.StoreInfoView.isHidden = true
        self.sellbettaLogoView.isHidden = true
        self.colorThemeView.isHidden = true
        self.addCategoryView.isHidden = true
        self.AddProductView.isHidden = true
        self.googleAnalyticsVieww.isHidden = true
        self.googleTagmanagerView.isHidden = true
        self.facebookPixelView.isHidden = false
        self.whatsappVieww.isHidden = true
    }
    
    
    @IBAction func facebookSkipBtn(_ sender: Any) {
        self.ThemeView.isHidden = true
        self.StoreInfoView.isHidden = true
        self.sellbettaLogoView.isHidden = true
        self.colorThemeView.isHidden = true
        self.addCategoryView.isHidden = true
        self.AddProductView.isHidden = true
        self.googleAnalyticsVieww.isHidden = true
        self.googleTagmanagerView.isHidden = false
        self.whatsappVieww.isHidden = false
    }
    
    @IBAction func whatsappRegisterActoin(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func facebookSaveBtnAction(_ sender: Any) {
        self.ThemeView.isHidden = true
        self.StoreInfoView.isHidden = true
        self.sellbettaLogoView.isHidden = true
        self.colorThemeView.isHidden = true
        self.addCategoryView.isHidden = true
        self.AddProductView.isHidden = true
        self.googleAnalyticsVieww.isHidden = true
        self.googleTagmanagerView.isHidden = false
        self.whatsappVieww.isHidden = false
    }
    
    
    @IBAction func BackLoginAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        print("hi")
    }
    
}

extension SignUpViewController: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView( _ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return myPickerData.count
        case 2:
            return myPickerServiceData.count
        case 3:
            return parentCategoryArray.count
        case 4:
            return featuredArray.count
        case 5:
            return AssignToArray.count
        case 6:
            return specialPriceArray.count
        case 7:
            return selectStatusArray.count
        case 8:
            return selectStatusArray.count
        case 9:
            return selectStatusArray.count
        case 10:
            return selectStatusArray.count
        default:
            return 1
        }
    }

    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return myPickerData[row]
        case 2:
            return myPickerServiceData[row]
        case 3:
            return parentCategoryArray[row]
        case 4:
            return featuredArray[row]
        case 5:
            return AssignToArray[row]
        case 6:
            return specialPriceArray[row]
        case 7:
            return selectStatusArray[row]
        case 8:
            return selectStatusArray[row]
        case 9:
            return selectStatusArray[row]
        case 10:
            return selectStatusArray[row]
        default:
            return "No data found"
        }
        
    }

    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            ProductTypeTF.text = myPickerData[row]
            ProductTypeTF.resignFirstResponder()
        case 2:
            serviceTF.text = myPickerServiceData[row]
            serviceTF.resignFirstResponder()
        case 3:
            selectCategoryTF.text = parentCategoryArray[row]
            selectCategoryTF.resignFirstResponder()
        case 4:
            selectFeatureTFProduct.text =  featuredArray[row]
            selectFeatureTFProduct.resignFirstResponder()
        case 5:
            selectAssignToTF.text = AssignToArray[row]
            selectAssignToTF.resignFirstResponder()
        case 6:
            selectProductSpecialPriceTF.text = specialPriceArray[row]
            selectProductSpecialPriceTF.resignFirstResponder()
        case 7:
            GoogleSelectStatusTF.text = selectStatusArray[row]
            GoogleSelectStatusTF.resignFirstResponder()
        case 8:
            TabManagerSelectStatusTF.text = selectStatusArray[row]
            TabManagerSelectStatusTF.resignFirstResponder()
        case 9:
            facebookStatusTF.text = selectStatusArray[row]
            facebookStatusTF.resignFirstResponder()
        case 10:
            whatsappStatusTF.text = selectStatusArray[row]
            whatsappStatusTF.resignFirstResponder()
        default:
            return
        }
    }

    
    
}
