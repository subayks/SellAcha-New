//
//  FilterPaymentCell.swift
//  SellAcha
//
//  Created by Subaykala on 12/10/23.
//

import UIKit

class FilterPaymentCell: UITableViewCell {

    @IBOutlet weak var picketTextField: UITextField!
    @IBOutlet weak var tableHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var statusTableView: UITableView!
    @IBOutlet weak var paymentStatusButton: UIButton!
    @IBOutlet weak var paymentStatusLabel: UILabel!
    let viewModel = FilterPaymentCellVM()
    var selectedCell = Int()
    var reloadClosure: ((Int, Bool)->())?
    let paymentPicker = UIPickerView()
    let fulfilementPicker = UIPickerView()
    var selectedPicker: ((Int, String)->())?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.statusTableView.isHidden = true
        self.tableHeightConstraints.constant = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        picketTextField.inputView = paymentPicker
        paymentPicker.delegate = self
        paymentPicker.dataSource = self
    }

    @IBAction func actionPayment(_ sender: UIButton) {
        self.statusTableView.isHidden = false
        self.selectedCell = sender.tag
        self.reloadClosure?(selectedCell, true)
    }
}

extension FilterPaymentCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.status.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = statusTableView.dequeueReusableCell(withIdentifier: "MonthCell") as! MonthCell
        cell.textLabel?.text = viewModel.status[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.statusTableView.isHidden = true
        self.reloadClosure?(selectedCell, false)
        self.paymentStatusButton.setTitle(viewModel.status[indexPath.row], for: .normal)
        self.paymentStatusButton.setImage(UIImage(systemName: "chevron.down.circle"), for: .normal)
    }
}
extension FilterPaymentCell: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView( _ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0:
            return self.viewModel.status.count
        case 1:
            return self.viewModel.status.count
        default:
            return 1
        }
    }

    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 0:
            return self.viewModel.status[row]
        case 1:
            return self.viewModel.status[row]
        default:
            return "No data found"
        }
        
    }

    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 0:
            picketTextField.text = self.viewModel.status[row]
            self.selectedPicker?(pickerView.tag, self.viewModel.status[row])
            picketTextField.resignFirstResponder()
        case 1:
            picketTextField.text = self.viewModel.status[row]
            self.selectedPicker?(pickerView.tag, self.viewModel.status[row])
            picketTextField.resignFirstResponder()
        default:
            return
        }
    }
}
