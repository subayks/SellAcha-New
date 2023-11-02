//
//  AttributeCell.swift
//  SellAcha
//
//  Created by apple on 23/10/23.
//

import UIKit

class AttributeCell: UITableViewCell {
    
    @IBOutlet weak var attributeNameLbl: UILabel!
    @IBOutlet weak var variationsLbl: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    
    var attributeCellVM: AttributeCellVM? {
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

        
    }
    
    func setupValues() {
        self.attributeNameLbl.text = self.attributeCellVM?.model.name
        self.variationsLbl.text = "N/A"
    }

}
