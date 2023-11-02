//
//  CreateOrderCell.swift
//  SellAcha
//
//  Created by apple on 25/10/23.
//

import UIKit

class CreateOrderCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var cartTF: UITextField!
    @IBOutlet weak var cartAddBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cartTF.addBottomBorder()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
