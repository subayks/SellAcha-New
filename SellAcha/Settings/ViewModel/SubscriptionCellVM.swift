//
//  SubscriptionCellVM.swift
//  SellAcha
//
//  Created by Subaykala on 07/11/23.
//

import Foundation
class SubscriptionCellVM {
    var model: SubscriptionModel?
    
    init(model: SubscriptionModel? = nil) {
        self.model = model
    }
    
    func dateStringToFormattedDateString() ->String {
        let myDateString = self.model?.createdAt ?? ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let myDate = dateFormatter.date(from: myDateString)!
        
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let somedateString = dateFormatter.string(from: myDate)
        return somedateString
    }
}
