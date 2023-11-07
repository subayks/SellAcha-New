//
//  ReportsCell.swift
//  SellAcha
//
//  Created by Subaykala on 23/10/23.
//

import UIKit

class ReportsCell: UITableViewCell {

    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var statusButton: UIButton!
    @IBOutlet weak var orderIdLabel: UILabel!
    
    var reportsCellVM: ReportsCellVM? {
        didSet {
            self.setupValues()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupValues() {
        self.orderIdLabel.text = self.reportsCellVM?.model.orderNo
        self.statusButton.setTitle(self.reportsCellVM?.model.status?.uppercased(), for: .normal)
        
        if self.reportsCellVM?.model.status?.lowercased() == "pending" {
            self.statusButton.backgroundColor = UIColor(red: 255/255, green: 149/255, blue: 0/255, alpha: 255/255)
        } else if self.reportsCellVM?.model.status?.lowercased() == "incomplete" {
            self.statusButton.backgroundColor = .red
        } else if self.reportsCellVM?.model.status?.lowercased() == "completed" {
            self.statusButton.backgroundColor = UIColor(red: 73/255, green: 194/255, blue: 96/255, alpha: 255/255)
        }
       
        let title = "₹" + "\(String(describing: self.reportsCellVM?.model.total ?? 0))"
        self.amountLabel.text = title
    }
}
