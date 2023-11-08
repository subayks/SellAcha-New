//
//  RatingVM.swift
//  SellAcha
//
//  Created by Subaykala on 22/10/23.
//

import Foundation
class RatingVM: BaseViewModel {
    var apiServices: ReviewAndRatingServiceProtocol?
    var model: [ReviewData]?
    var originalModel: [ReviewData]?
    
    init(apiServices: ReviewAndRatingServiceProtocol = ReviewAndRatingService()) {
        self.apiServices = apiServices
    }
    
    func getReviewList() {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingIndicatorClosure?()
            
            self.apiServices?.getRating(finalURL: "\(Constants.Common.finalURL)/api/get_review", httpHeaders: [String:String](), withParameters: "", completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                self.hideLoadingIndicatorClosure?()
                
                DispatchQueue.main.async {
                    if status == true {
                        let array = result as? BaseResponse<ReviewModel>
                        self.model = array?.data?.posts?.data
                        self.originalModel = array?.data?.posts?.data
                        self.reloadTableView?()
                    }
                    else{
                        self.alertClosure?(errorMessage ?? "Some Technical Problem")
                    }
                }
            })
        }
        else {
            self.alertClosure?("No Internet Availabe")
        }
    }
    
    func getRatingCellVM(index: Int) ->RatingCellVM {
        RatingCellVM(ratingData: self.model?[index] ?? ReviewData())
    }
    
    func sorting(keyword: String) {
        if keyword.count > 0 && keyword != "" {
            var postArray = [ReviewData]()
            if let posts = self.originalModel {
                for item in posts {
                    if (item.name ?? "").lowercased().contains(keyword.lowercased()) {
                        postArray.append(item)
                    }
                }
            }
            self.model = postArray
        } else {
            self.model = self.originalModel
        }
        self.reloadTableView?()
    }
    
    
}
