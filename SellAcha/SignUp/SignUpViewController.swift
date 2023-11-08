//
//  SignUpViewController.swift
//  SellAcha
//
//  Created by apple on 26/10/23.
//

import UIKit
import Photos

class SignUpViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var logoMakerIMage: UIImageView!
    @IBOutlet weak var tickImage4: UIImageView!
    @IBOutlet weak var tickImage3: UIImageView!
    @IBOutlet weak var tickIMage2: UIImageView!
    @IBOutlet weak var tickImage1: UIImageView!
    @IBOutlet weak var loadView4: UIView!
    @IBOutlet weak var loadView3: UIView!
    @IBOutlet weak var loadView2: UIView!
    @IBOutlet weak var loadView1: UIView!
    @IBOutlet weak var googleIMageTitle: UILabel!
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
    @IBOutlet weak var userScrollView: UIScrollView!
    @IBOutlet weak var uploadLogoScrollview: UIScrollView!
    @IBOutlet weak var colorSchemeScrollview: UIScrollView!
    @IBOutlet weak var storeRegistrationScrollview: UIScrollView!
    @IBOutlet weak var whatsappScrollview: UIScrollView!

    var logoImageSelected = false
    var logoImageTapped = false

    var faviconSelected = false
    var faviconTapped = false

    var isThubnailSelected = false
    var isThubnailTapped = false
    
    var isGooleImageTapped = false

    var vm = SignupViewModel()
    
    // datepicker
    let StartdatePicker = UIDatePicker()
    let endDatePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.navigationController?.navigationBar.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
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
        
        self.passwordTF.isSecureTextEntry = true
        self.confirmPasswordTF.isSecureTextEntry = true
        self.logoSelectLbl.text = "No file Chosen"
        self.logoSelectLbl.textColor = UIColor.lightGray
        
        self.favIconSelectedLbl.text = "No file Chosen"
        self.favIconSelectedLbl.textColor = UIColor.lightGray
        let tap = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.tapFunction))
        logoIconImg.isUserInteractionEnabled = true
        logoIconImg.addGestureRecognizer(tap)
        
        let favIconImgTap = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.tapFaviconFunction))
        favIconImg.isUserInteractionEnabled = true
        favIconImg.addGestureRecognizer(favIconImgTap)
        
        self.tickImage1.isHidden = true
        self.tickIMage2.isHidden = true
        self.tickImage3.isHidden = true
        self.tickImage4.isHidden = true
        
        tickImage4.layer.cornerRadius = tickImage4.frame.size.width/2
        tickImage3.layer.cornerRadius = tickImage3.frame.size.width/2
        tickIMage2.layer.cornerRadius = tickIMage2.frame.size.width/2
        tickImage1.layer.cornerRadius = tickImage1.frame.size.width/2
        
        
        // datepicker
        StartdatePicker.datePickerMode = .date
        endDatePicker.datePickerMode = .date
        
        // Create a toolbar with a "Done" button to dismiss the date picker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([doneButton], animated: true)
        productPricestartsTF.inputAccessoryView = toolbar
        productPricestartsTF.inputView = StartdatePicker
        
        let Endtoolbar = UIToolbar()
        Endtoolbar.sizeToFit()
        let EnddoneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(EnddoneButtonTapped))
        Endtoolbar.setItems([EnddoneButton], animated: true)
        productPriceEndsTF.inputAccessoryView = Endtoolbar
        productPriceEndsTF.inputView = endDatePicker
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        logoMakerIMage.isUserInteractionEnabled = true
        logoMakerIMage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let alert = UIAlertController(title: "Alert", message: "You are leaving application, are you sure?", preferredStyle: UIAlertController.Style.alert)
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { action in
            if let url = URL(string: "https://sellacha.com/logo.html"), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func doneButtonTapped() {
        // Format the date and update the text field's text
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        productPricestartsTF.text = dateFormatter.string(from: StartdatePicker.date)
        
        // Dismiss the date picker
        productPricestartsTF.resignFirstResponder()
        }
    
    @objc func EnddoneButtonTapped() {
        // Format the date and update the text field's text
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        productPriceEndsTF.text = dateFormatter.string(from: endDatePicker.date)
        // Dismiss the date picker
        productPriceEndsTF.resignFirstResponder()
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
        
        self.vm.allowToPhotos = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                let pickerController = UIImagePickerController()
                pickerController.delegate = self
                pickerController.allowsEditing = true
                self.present(pickerController, animated: true)            }
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                userScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
                uploadLogoScrollview.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
                colorSchemeScrollview.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
                whatsappScrollview.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
                storeRegistrationScrollview.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        userScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        uploadLogoScrollview.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        colorSchemeScrollview.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        whatsappScrollview.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        storeRegistrationScrollview.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        self.logoImageTapped = true
        self.vm.requestPhotoAccess()
    }
    
    @objc func tapFaviconFunction(sender:UITapGestureRecognizer) {
        self.faviconTapped = true
        self.vm.requestPhotoAccess()
    }
    
    @IBAction func saveBtnAction(_ sender: Any) {
        if BusinessNameTF.text == "" || (BusinessNameTF.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true) {
            let alert = UIAlertController(title: "Alert", message: "Please enter Business Name", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        if mobileNumberTF.text == "" || (mobileNumberTF.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true) {
            let alert = UIAlertController(title: "Alert", message: "Please enter Mobile Number", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        if mobileNumberTF.text?.count ?? 0 > 10 || mobileNumberTF.text?.count ?? 0 < 10 {
            let alert = UIAlertController(title: "Alert", message: "Please enter Valid mobile Number", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        if self.ProductTypeTF.text == "" {
            let alert = UIAlertController(title: "Alert", message: "Please Select Shop Type", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        if emailTF.text == "" || (emailTF.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true) {
            let alert = UIAlertController(title: "Alert", message: "Please enter Email Address", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        if !self.vm.isValidEmail(self.emailTF.text ?? "") {
            let alert = UIAlertController(title: "Alert", message: "Please enter valid Email Address", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        if passwordTF.text == "" || (passwordTF.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true) {
            let alert = UIAlertController(title: "Alert", message: "Please enter Password", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        if (passwordTF.text?.count ?? 0) < 8 {
            let alert = UIAlertController(title: "Alert", message: "Please enter Min 8 character in password field", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        if confirmPasswordTF.text == "" || (confirmPasswordTF.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true) {
            let alert = UIAlertController(title: "Alert", message: "Please enter Confirm Password", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        if confirmPasswordTF.text != self.passwordTF.text {
            let alert = UIAlertController(title: "Alert", message: "Password does not Match", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        if self.serviceTF.text == "" {
            let alert = UIAlertController(title: "Alert", message: "Please Select Service", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
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
        
        self.tickImage1.isHidden = false
        self.buttonOne.backgroundColor = UIColor(red: 73/255, green: 194/255, blue: 96/255, alpha: 255/255)
        self.buttonTwo.backgroundColor = UIColor(red: 0/255, green: 67/255, blue: 129/255, alpha: 255/255)
        self.loadView1.backgroundColor =  UIColor(red: 73/255, green: 194/255, blue: 96/255, alpha: 255/255)
    }
    
    @IBAction func installRadioBtnAction(_ sender: Any) {
        radiBtnInstall.setImage(UIImage(named: "radioOn"), for: .normal)
    }
    
    @IBAction func activeRadioButtonAction(_ sender: Any) {
        radiBtnActive.setImage(UIImage(named: "radioOn"), for: .normal)
    }
    
    @IBAction func chooseFileGalleryAction(_ sender: Any) {
        self.isThubnailTapped = true
        self.vm.requestPhotoAccess()
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
        if brandTF.text == "" || (brandTF.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true) {
            let alert = UIAlertController(title: "Alert", message: "Please enter Brand Name", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        if tagLineTF.text == "" || (tagLineTF.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true) {
            let alert = UIAlertController(title: "Alert", message: "Please enter Tag Line", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
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
        if themeColorTF.text == "" || (themeColorTF.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true) {
            let alert = UIAlertController(title: "Alert", message: "Please enter Theme Color", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        if !logoImageSelected {
            let alert = UIAlertController(title: "Alert", message: "Please select Logo Image", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        if !faviconSelected {
            let alert = UIAlertController(title: "Alert", message: "Please select Favicon Image", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
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
        
        self.tickIMage2.isHidden = false
        self.buttonTwo.backgroundColor = UIColor(red: 73/255, green: 194/255, blue: 96/255, alpha: 255/255)
        self.buttonThree.backgroundColor = UIColor(red: 0/255, green: 67/255, blue: 129/255, alpha: 255/255)
        self.loadView2.backgroundColor =  UIColor(red: 73/255, green: 194/255, blue: 96/255, alpha: 255/255)
    }
    
    @IBAction func cateogrySaveBtnAction(_ sender: Any) {
        if productTitleTF.text == "" || (productTitleTF.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true) {
            let alert = UIAlertController(title: "Alert", message: "Please enter Name Field", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        if selectCategoryTF.text == "" {
            let alert = UIAlertController(title: "Alert", message: "Please Select Category", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        if selectFeatureTFProduct.text == "" {
            let alert = UIAlertController(title: "Alert", message: "Please Select Featured", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        if selectAssignToTF.text == "" {
            let alert = UIAlertController(title: "Alert", message: "Please Select AssignTo", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        if !isThubnailSelected {
            let alert = UIAlertController(title: "Alert", message: "Please choose Thumbnail", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
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
        if product.text == "" || (product.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true) {
            let alert = UIAlertController(title: "Alert", message: "Please enter Title", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        if productPrice.text == "" || (productPrice.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true) {
            let alert = UIAlertController(title: "Alert", message: "Please enter Price", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        if productSpecialPrice.text == "" || (productSpecialPrice.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true) {
            let alert = UIAlertController(title: "Alert", message: "Please enter Special Price", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        if selectProductSpecialPriceTF.text == "" || (selectProductSpecialPriceTF.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true) {
            let alert = UIAlertController(title: "Alert", message: "Please Choose Product Type", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        if productPricestartsTF.text == "" || (productPricestartsTF.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true) {
            let alert = UIAlertController(title: "Alert", message: "Please Choose Start Date", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        if productPriceEndsTF.text == "" || (productPriceEndsTF.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true) {
            let alert = UIAlertController(title: "Alert", message: "Please Choose End Date", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
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
        
        self.tickImage3.isHidden = false
        self.buttonThree.backgroundColor = UIColor(red: 73/255, green: 194/255, blue: 96/255, alpha: 255/255)
        self.buttonFour.backgroundColor = UIColor(red: 0/255, green: 67/255, blue: 129/255, alpha: 255/255)
        self.loadView3.backgroundColor =  UIColor(red: 73/255, green: 194/255, blue: 96/255, alpha: 255/255)
    }
    
    @IBAction func googleSkipBtnAction(_ sender: Any) {
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
    
    
    @IBAction func googleChooseFileBtnAction(_ sender: Any) {
        self.isGooleImageTapped = true
        self.vm.requestPhotoAccess()
    }
    
    
    @IBAction func gooleSavebtnAction(_ sender: Any) {
        if GoogleMeasurIDTF.text == "" || (GoogleMeasurIDTF.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true) {
            let alert = UIAlertController(title: "Alert", message: "Please enter GA-MEASUREMENT-ID", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        if GoogleAnalyticsViewIdTF.text == "" || (GoogleAnalyticsViewIdTF.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true) {
            let alert = UIAlertController(title: "Alert", message: "Please enter Analytics View Id", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        if GoogleSelectStatusTF.text == "" || (GoogleSelectStatusTF.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true) {
            let alert = UIAlertController(title: "Alert", message: "Please Choose Status", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        
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
        if TabManagerIDTF.text == "" || (TabManagerIDTF.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true) {
            let alert = UIAlertController(title: "Alert", message: "Please enter Tag Manager ID", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        if TabManagerSelectStatusTF.text == "" || (TabManagerSelectStatusTF.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true) {
            let alert = UIAlertController(title: "Alert", message: "Please Choose Status", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        
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
        self.googleTagmanagerView.isHidden = true
        self.facebookPixelView.isHidden = true
        self.whatsappVieww.isHidden = false
    }
    
    @IBAction func whatsappRegisterActoin(_ sender: Any) {
        if whatappNumberTF.text != ""  {
            if whatappNumberTF.text?.count ?? 0 > 10 || whatappNumberTF.text?.count ?? 0 < 10 {
                let alert = UIAlertController(title: "Alert", message: "Please enter Valid Mobile Number", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
        }

        if whatsappStatusTF.text == "" || (whatsappStatusTF.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true) {
            let alert = UIAlertController(title: "Alert", message: "Please Choose Status", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        self.vm.makeSignUp(email: self.emailTF.text ?? "", password: self.passwordTF.text ?? "", sertype: self.serviceTF.text ?? "", refrral: "", mob: self.mobileNumberTF.text ?? "", themeColor: self.themeColorTF.text ?? "", pId: "", featured: self.selectFeatureTFProduct.text ?? "", menuStatus: "Yes", price: self.productPrice.text ?? "", astatus: self.GoogleSelectStatusTF.text ?? "", gfile: "", tstatus: self.TabManagerSelectStatusTF.text ?? "", pstatus: self.facebookStatusTF.text ?? "", wstatus: self.whatsappStatusTF.text ?? "", name: self.BusinessNameTF.text ?? "", domain: self.BusinessNameTF.text ?? "", customDomain: self.BusinessNameTF.text ?? "", utype: "product", businessName: self.BusinessNameTF.text ?? "", shopType: self.ProductTypeTF.text ?? "", cname: self.selectCategoryTF.text ?? "", title: self.product.text ?? "", specialPriceStart: self.productPricestartsTF.text ?? "", specialPrice: self.productSpecialPrice.text ?? "", priceType: self.selectProductSpecialPriceTF.text ?? "", type: self.ProductTypeTF.text ?? "", specialPriceEnd: self.productPriceEndsTF.text ?? "", gaMeasurementId: self.GoogleMeasurIDTF.text ?? "", analyticsViewId: self.GoogleAnalyticsViewIdTF.text ?? "", tagId: self.TabManagerIDTF.text ?? "", pixelId: self.facebookPixelTF.text ?? "", number: self.whatappNumberTF.text ?? "", shopPagePretext: self.whatsappPurchaseProductTF.text ?? "", otherPagePretext: self.whatsappQueryTF.text ?? "", plnt: "1")
        
        self.tickImage4.isHidden = false
        self.buttonFour.backgroundColor = UIColor(red: 73/255, green: 194/255, blue: 96/255, alpha: 255/255)
        self.loadView4.backgroundColor =  UIColor(red: 73/255, green: 194/255, blue: 96/255, alpha: 255/255)
    }
    
    @IBAction func facebookSaveBtnAction(_ sender: Any) {
        
        if facebookPixelTF.text == "" || (facebookPixelTF.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true) {
            let alert = UIAlertController(title: "Alert", message: "Please enter Pixel ID", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        if facebookStatusTF.text == "" || (facebookStatusTF.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true) {
            let alert = UIAlertController(title: "Alert", message: "Please Choose Status", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
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
extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImageFromPicker: UIImage?
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImageFromPicker = editedImage
        } else {
            selectedImageFromPicker = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        }
        if logoImageTapped {
            self.logoIconImg.image = selectedImageFromPicker
            self.logoImageTapped = false
            self.logoSelectLbl.text = "Logo Selected"
            self.logoSelectLbl.textColor = UIColor(red: 112/255, green: 167/255, blue: 0/255, alpha: 255/255)
            self.logoImageSelected = true
        }
        
        if faviconTapped {
            self.favIconImg.image = selectedImageFromPicker
            self.faviconTapped = false
            self.favIconSelectedLbl.text = "Favicon Selected"
            self.favIconSelectedLbl.textColor = UIColor(red: 112/255, green: 167/255, blue: 0/255, alpha: 255/255)
            self.faviconSelected = true
        }
        
        if isThubnailTapped {
            self.isThubnailSelected = true
            self.isThubnailTapped = false
            if let asset = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerPHAsset")] as? PHAsset{
                if let fileName = asset.value(forKey: "filename") as? String{
                    self.filechoosenLbl.text = fileName
                }
            }
        }
        
        if isGooleImageTapped {
            self.isGooleImageTapped = false
            if let asset = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerPHAsset")] as? PHAsset{
                if let fileName = asset.value(forKey: "filename") as? String{
                    self.googleIMageTitle.text = fileName
                }
            }
        }
        dismiss(animated: true)
    }
}
