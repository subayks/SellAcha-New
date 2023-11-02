//
//  OrderInfoCellVM.swift
//  SellAcha
//
//  Created by Subaykala on 23/10/23.
//

import Foundation
class OrderInfoCellVM {
    var model: OrdersData
    
    init(model: OrdersData) {
        self.model = model
    }
    
    func dateStringToFormattedDateString() ->String {
        let myDateString = self.model.createdAt ?? ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let myDate = dateFormatter.date(from: myDateString)!
        
        dateFormatter.dateFormat = "dd MMM, YYYY"
        let somedateString = dateFormatter.string(from: myDate)
        return somedateString
    }
}
