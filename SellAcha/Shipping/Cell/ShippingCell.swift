//
//  ShippingCell.swift
//  SellAcha
//
//  Created by Subaykala on 25/10/23.
//

import UIKit

class ShippingCell: UITableViewCell {
 
    @IBOutlet weak var buttonDelete: UIButton!
    @IBOutlet weak var buttonEdit: UIButton!
    @IBOutlet weak var colorLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    var vm: ShippingCellVM? {
        didSet {
            self.setupView()
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

    func setupView() {
        self.colorLabel.text = self.vm?.model?.name
        self.statusLabel.text = self.vm?.model?.slug
    }
}
