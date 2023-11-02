//
//  FilterDateCell.swift
//  SellAcha
//
//  Created by Subaykala on 12/10/23.
//

import UIKit

class FilterDateCell: UITableViewCell {
    
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    let datePicker = UIDatePicker()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func actionDate(_ sender: Any) {
        
    }
}
