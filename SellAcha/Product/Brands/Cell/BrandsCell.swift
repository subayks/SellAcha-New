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
        if self.vm?.model.preview?.content != nil && self.vm?.model.preview?.content != "" {
            let urlString =  "www.sellacha.com/" + (self.vm?.model.preview?.content ?? "")
            
            let url = URL(string: urlString)
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            imageBrand.image = UIImage(data: data ?? Data())
        }
    }
}
