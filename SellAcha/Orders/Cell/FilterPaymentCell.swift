//
//  FilterPaymentCell.swift
//  SellAcha
//
//  Created by Subaykala on 12/10/23.
//

import UIKit

class FilterPaymentCell: UITableViewCell {

    @IBOutlet weak var tableHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var statusTableView: UITableView!
    @IBOutlet weak var paymentStatusButton: UIButton!
    @IBOutlet weak var paymentStatusLabel: UILabel!
    let viewModel = FilterPaymentCellVM()
    var selectedCell = Int()
    var reloadClosure: ((Int, Bool)->())?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.statusTableView.isHidden = true
        self.tableHeightConstraints.constant = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
