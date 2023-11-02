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
    
    var vm: CategoriesCellVM? {
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
        self.CategoriesnamesLbl.text = self.vm?.model.name
        if self.vm?.model.preview?.content != nil && self.vm?.model.preview?.content != "" {
            let urlString =  "www.sellacha.com/" + (self.vm?.model.preview?.content ?? "")

            let url = URL(string: urlString)
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            CategoriesImage.image = UIImage(data: data ?? Data())
        }
    }

}
