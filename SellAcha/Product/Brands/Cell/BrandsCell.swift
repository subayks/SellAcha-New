//
//  BrandsCell.swift
//  SellAcha
//
//  Created by apple on 23/10/23.
//

import UIKit

class BrandsCell: UITableViewCell {

    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var buttonDelete: UIButton!
    @IBOutlet weak var imageBrand: UIImageView!
    
    var vm: BrandsCellVM? {
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
        self.namelabel.text = self.vm?.model.name

    }

}
