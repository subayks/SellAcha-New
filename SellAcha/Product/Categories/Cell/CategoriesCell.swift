//
//  CategoriesCell.swift
//  SellAcha
//
//  Created by apple on 23/10/23.
//

import UIKit

class CategoriesCell: UITableViewCell {

    @IBOutlet weak var CategoriesImage: UIImageView!
    @IBOutlet weak var CategoriesnamesLbl: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    
    var attributeCellVM: CategoriesCellVM? {
        didSet {
            self.setupValues()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func setupValues() {

    }

}
