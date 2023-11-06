//
//  OrderFilterView.swift
//  SellAcha
//
//  Created by Subaykala on 12/10/23.
//

import UIKit

class OrderFilterView: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var calendarOverView: UIView!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var filterTableView: UITableView!
    let viewModel = OrderFilterViewModel()
    var isStartDateClicked: Bool = false
    var isEndDateClicked: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isOpaque = false
        self.viewModel.createDataModel()
        
        self.calendarOverView.isHidden = true
        self.datePicker.isHidden = true
        datePicker.addTarget(self, action: #selector(dateSelected), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.viewModel.errorClosure = { [weak self] (error) in
            DispatchQueue.main.async {
                guard let self = self else {return}
                if error != "" {
                    let alert = UIAlertController(title: "Alert", message: error, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
        self.viewModel.alertClosure = { [weak self] (error) in
            DispatchQueue.main.async {
                guard let self = self else {return}
                let alert = UIAlertController(title: "Alert", message: error, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        self.viewModel.showLoadingIndicatorClosure = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.showSpinner(onView: self.view)
            }
        }
        
        self.viewModel.hideLoadingIndicatorClosure = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.removeSpinner()
            }
        }
        
        self.viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.filterTableView.reloadData()
            }
        }
    }
    
    @IBAction func dismissView(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func actionFilter(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func actionDatePicker(_ sender: UIButton) {
        if sender.tag == 2 {
            self.isStartDateClicked = true
        } else {
            self.isEndDateClicked = true
        }
        
        self.calendarOverView.isHidden = false
        self.datePicker.isHidden = false
    }
    
    @objc func dateSelected() {
        if self.isStartDateClicked {
            self.isStartDateClicked = false
            self.viewModel.dataModel[2].value = datePicker.date.toString(dateFormat: "YYYY-MM-dd")
            DispatchQueue.main.async {
                self.filterTableView.reloadRows(at: [IndexPath(row: 2, section: 0)], with: .automatic)
            }
        } else {
            self.isEndDateClicked = false
            self.viewModel.dataModel[3].value = datePicker.date.toString(dateFormat: "YYYY-MM-dd")
            DispatchQueue.main.async {
                self.filterTableView.reloadRows(at: [IndexPath(row: 3, section: 0)], with: .automatic)
            }
        }
        self.datePicker.isHidden = true
        self.calendarOverView.isHidden = true
    }
}

extension OrderFilterView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.dataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.viewModel.dataModel[indexPath.row].title ==  "Payment Status" || self.viewModel.dataModel[indexPath.row].title ==  "Fulfilment Status" {
            let cell = filterTableView.dequeueReusableCell(withIdentifier: "FilterPaymentCell") as! FilterPaymentCell
            cell.paymentStatusLabel.text = self.viewModel.dataModel[indexPath.row].title
            cell.paymentStatusButton.tag = indexPath.row
            cell.picketTextField.tag = indexPath.row
            cell.paymentPicker.tag = indexPath.row
            cell.reloadClosure = { (index, show)  in
                if show {
                    cell.tableHeightConstraints.constant = 128
                    cell.statusTableView.isHidden = false
                } else {
                    cell.tableHeightConstraints.constant = 0
                    cell.statusTableView.isHidden = true
                }
                DispatchQueue.main.async {
                    self.filterTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                }
            }
            return cell
        } else {
            let cell = filterTableView.dequeueReusableCell(withIdentifier: "FilterDateCell") as! FilterDateCell
            cell.dateLabel.text = self.viewModel.dataModel[indexPath.row].title
            cell.dateButton.setTitle(self.viewModel.dataModel[indexPath.row].value, for: .normal)
            cell.dateButton.tag = indexPath.row
            return cell
        }
    }
}
