//
//  RatingCellVM.swift
//  SellAcha
//
//  Created by Subaykala on 25/10/23.
//

import Foundation
class RatingCellVM: BaseViewModel {
    var ratingData: ReviewData?
    
    init(ratingData: ReviewData) {
        self.ratingData = ratingData
    }
}
