//
//  ReportsVC.swift
//  SellAcha
//
//  Created by Subaykala on 21/10/23.
//

import UIKit

class ReportsVC: UIViewController {
    @IBOutlet weak var overViewtwo: UIView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var headeroverView: UIView!
    @IBOutlet weak var stackSubView: UIView!
    @IBOutlet weak var imageRefresh: UIImageView!
    @IBOutlet weak var imageSearch: UIImageView!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var reportsTableView: UITableView!

    @IBOutlet weak var calendarOverView: UIView!
    let vm = ReportsVM()
    var isStartDateClicked: Bool = false
    var isEndDateClicked: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.vm.getReportList()
        self.imageRefresh.layer.cornerRadius = 10
        self.imageSearch.layer.cornerRadius = 10
        self.startDateLabel.text =  "YYYY-MM-dd"
        self.endDateLabel.text =  "YYYY-MM-dd"
        
        self.datePicker.isHidden = true
        self.calendarOverView.isHidden = true
        datePicker.addTarget(self, action: #selector(dateSelected), for: .valueChanged)

        self.overView.layer.cornerRadius = 30
        self.headeroverView.layer.cornerRadius = 10
        self.overViewtwo.layer.cornerRadius = 30
        self.stackSubView.layer.cornerRadius = 10
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageSearch.isUserInteractionEnabled = true
        imageSearch.addGestureRecognizer(tapGestureRecognizer)
        
        let imageRefreshGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageRefresh(tapGestureRecognizer:)))
        imageRefresh.isUserInteractionEnabled = true
        imageRefresh.addGestureRecognizer(imageRefreshGestureRecognizer)
        
        let startDateGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(startDateClicked(tapGestureRecognizer:)))
        startDateLabel.isUserInteractionEnabled = true
        startDateLabel.addGestureRecognizer(startDateGestureRecognizer)
        
        let endDateGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(endDateClicked(tapGestureRecognizer:)))
        endDateLabel.isUserInteractionEnabled = true
        endDateLabel.addGestureRecognizer(endDateGestureRecognizer)
        
//        self.calendarPickerView.changeClosure = { date in
//            if self.isStartDateClicked {
//                self.isStartDateClicked = false
//                self.startDateLabel.text = date.toString(dateFormat: "YYY-MM-dd")
//            } else {
//                self.isEndDateClicked = false
//                self.endDateLabel.text =  date.toString(dateFormat: "YYY-MM-dd")
//            }
//            self.calendarPickerView.isHidden = true
//        }
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
        
        self.vm.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.reportsTableView.reloadData()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        overView.roundCorners(corners: [.topLeft , .topRight], radius: 30)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        if self.startDateLabel.text != "YYYY-MM-dd" && self.endDateLabel.text != "YYYY-MM-dd" {
            self.vm.getTransactionbyID(startDate: self.startDateLabel.text ?? "", endDate: self.endDateLabel.text ?? "")
        } else {
            let alert = UIAlertController(title: "Alert", message: "Please fill the Date Fields", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func imageRefresh(tapGestureRecognizer: UITapGestureRecognizer) {
        self.startDateLabel.text = "YYYY-MM-dd"
        self.endDateLabel.text = "YYYY-MM-dd"
        self.vm.getReportList()
    }
    
    @objc func startDateClicked(tapGestureRecognizer: UITapGestureRecognizer) {
        self.isStartDateClicked = true
        self.datePicker.isHidden = false
        self.calendarOverView.isHidden = false
    }
    
    @objc func dateSelected() {
        if self.isStartDateClicked {
            self.isStartDateClicked = false
            self.startDateLabel.text = datePicker.date.toString(dateFormat: "YYYY-MM-dd")
        } else {
            self.isEndDateClicked = false
            self.endDateLabel.text =  datePicker.date.toString(dateFormat: "YYYY-MM-dd")
        }
        self.datePicker.isHidden = true
        self.calendarOverView.isHidden = true
    }
    
    @objc func endDateClicked(tapGestureRecognizer: UITapGestureRecognizer) {
        self.isEndDateClicked = true
        self.datePicker.isHidden = false
        self.calendarOverView.isHidden = false
    }
}

extension ReportsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.model?.orders?.data?.count  == 0 ? 1:self.vm.model?.orders?.data?.count ?? 1
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerHeaderCell") as! CustomerHeaderCell
        cell.headertitleStack.layer.cornerRadius = 5
        return cell
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.vm.model?.orders?.data?.count == nil {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MonthCell") as! MonthCell
            cell.textLabel?.text = ""
            return cell
        }
        if self.vm.model?.orders?.data?.count == 0 || self.vm.model?.orders?.data?.count == nil {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MonthCell") as! MonthCell
            cell.textLabel?.text = "No Records Found"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReportsCell") as! ReportsCell
            cell.statusButton.layer.cornerRadius = 10
            cell.reportsCellVM = self.vm.getReportsCellVM(index: indexPath.row)
            return cell
        }
    }
}
