//
//  LocationCell.swift
//  SellAcha
//
//  Created by Subaykala on 25/10/23.
//

import UIKit

class LocationCell: UITableViewCell {

    @IBOutlet weak var buttonEdit: UIButton!
    @IBOutlet weak var buttonDelete: UIButton!
    @IBOutlet weak var labelID: UILabel!
    
    var vm: LocationCellVM? {
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
        self.labelID.text = self.vm?.model?.name
    }

}
