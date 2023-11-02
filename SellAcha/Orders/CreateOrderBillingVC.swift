//
//  CreateOrderBillingVC.swift
//  SellAcha
//
//  Created by apple on 25/10/23.
//

import UIKit

class CreateOrderBillingVC: UIViewController {

    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var cartItemView: UIView!
    @IBOutlet weak var billingAddressView: UIView!
    @IBOutlet weak var shippingView: UIView!
    @IBOutlet weak var paymentStatusView: UIView!
    @IBOutlet weak var paymentMethodView: UIView!
    
    @IBOutlet weak var ctypeTB: UITableView!
    @IBOutlet weak var dtypeTypeTB: UITableView!
    @IBOutlet weak var loctionTB: UITableView!
    
    
    @IBOutlet weak var promocodeTF: UITextField!
    @IBOutlet weak var cNameTF: UITextField!
    @IBOutlet weak var cEmailTF: UITextField!
    @IBOutlet weak var cPhoneTF: UITextField!
    
    @IBOutlet weak var CustomerTypeLbl: UILabel!
    @IBOutlet weak var deliveryTypeLbl: UILabel!
    @IBOutlet weak var lucknowLbl:UILabel!
    
    let vm = GoogleAnalyticsVM()
    
   

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        ctypeTB.isHidden = true
        dtypeTypeTB.isHidden = true
        loctionTB.isHidden = true
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        cartItemView.roundCorners(corners: [.topLeft , .topRight], radius: 30)
        billingAddressView.roundCorners(corners: [.topLeft , .topRight], radius: 30)
        shippingView.roundCorners(corners: [.topLeft , .topRight], radius: 30)
        paymentStatusView.roundCorners(corners: [.topLeft , .topRight], radius: 30)
        paymentMethodView.roundCorners(corners: [.topLeft , .topRight], radius: 30)
        overView.roundCorners(corners: [.topLeft , .topRight], radius: 30)
    }
    
    @IBAction func reedemAction(_ sender: Any) {
        
    }
    @IBAction func ctypeAction(_ sender: Any) {
        ctypeTB.isHidden = false
    }
    @IBAction func deliverytypeAction(_ sender: Any) {
        dtypeTypeTB.isHidden = false
    }
    @IBAction func locationtypeAction(_ sender: Any) {
        loctionTB.isHidden = false
    }
    
    
    
    @IBAction func paymentPendingAction(_ sender: Any) {
        
        
    }
    @IBAction func paymentCompleteAction(_ sender: Any) {
        
        
    }
    
    @IBAction func paymentMobileAction(_ sender: Any) {
        
        
    }
    @IBAction func paymentCODAction(_ sender: Any) {
        
        
    }
    

}
 
//extension CreateOrderBillingVC:UITableViewDelegate,UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        if tableView == ctypeTB{
//
//        }
//       else if tableView == dtypeTypeTB{
//
//        }
//        else if  tableView == loctionTB{
//
//        }
//        return 0
//
//
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if tableView == ctypeTB{
//            let cell = ctypeTB.dequeueReusableCell(withIdentifier: "MonthCell",for: indexPath)
//            cell.textLabel?.text = self.vm.status[indexPath.row]
//            return cell
//
//        }
//
//        else  if tableView == dtypeTypeTB{
//            let cell = dtypeTypeTB.dequeueReusableCell(withIdentifier: "MonthCell",for: indexPath)
//            cell.textLabel?.text = self.vm.status[indexPath.row]
//            return cell
//        }
//
//        else if  tableView == loctionTB{
//            let cell = loctionTB.dequeueReusableCell(withIdentifier: "MonthCell",for: indexPath)
//            cell.textLabel?.text = self.vm.status[indexPath.row]
//            return cell
//        }
//        return
//
//        }
//
//
//    }
    
class ShadowView: UIView {
    override var bounds: CGRect {
        didSet {
            setupShadow()
        }
    }

    private func setupShadow() {
        self.layer.cornerRadius = 8
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.3
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8, height: 8)).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}

