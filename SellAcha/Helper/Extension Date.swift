//
//  Extension Date.swift
//  SellAcha
//
//  Created by Subaykala on 25/10/23.
//

import Foundation
extension Date {
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
