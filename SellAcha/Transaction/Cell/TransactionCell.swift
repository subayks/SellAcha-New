//
//  TransactionCell.swift
//  SellAcha
//
//  Created by Subaykala on 21/10/23.
//

import UIKit

class TransactionCell: UITableViewCell {
    @IBOutlet weak var orderNoLabel: UILabel!
    @IBOutlet weak var transactionLabel: UILabel!
    @IBOutlet weak var methodLabel: UILabel!
    @IBOutlet weak var transactionValueLabel: UILabel!
    @IBOutlet weak var pendingButton: UIButton!
    @IBOutlet weak var codLabel: UILabel!
    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var paymentLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var transactionAmountLabel: UILabel!
    
    var transactionCellVM: TransactionCellVM? {
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
        self.orderNumberLabel.text = self.transactionCellVM?.model.orderNo
        self.transactionValueLabel.text = self.transactionCellVM?.model.transactionId
        self.pendingButton.setTitle(self.transactionCellVM?.model.status?.uppercased(), for: .normal)
        
        if self.transactionCellVM?.model.status?.lowercased() == "pending" {
            self.pendingButton.backgroundColor = UIColor(red: 255/255, green: 149/255, blue: 0/255, alpha: 255/255)
        } else if self.transactionCellVM?.model.status?.lowercased() == "incomplete" {
            self.pendingButton.backgroundColor = .red
        } else if self.transactionCellVM?.model.status?.lowercased() == "completed" {
            self.pendingButton.backgroundColor = UIColor(red: 73/255, green: 194/255, blue: 96/255, alpha: 255/255)
        }
       
        self.codLabel.text = self.transactionCellVM?.model.getway?.name
        
        self.transactionAmountLabel.text = "\(String(describing: self.transactionCellVM?.model.total ?? 0))"
    }

}
