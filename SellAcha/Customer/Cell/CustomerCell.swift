//
//  CustomerCell.swift
//  SellAcha
//
//  Created by Subaykala on 23/10/23.
//

import UIKit

class CustomerCell: UITableViewCell {
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var delete: UIButton!
    @IBOutlet weak var mailLabel: UILabel!
    
    var vm: CustomerCellVM? {
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
        self.nameLabel.text = self.vm?.model.name
        self.mailLabel.text = self.vm?.model.email
    }
}
