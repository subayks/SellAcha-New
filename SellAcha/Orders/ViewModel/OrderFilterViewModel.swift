//
//  OrderFilterViewModel.swift
//  SellAcha
//
//  Created by Subaykala on 12/10/23.
//

import Foundation

struct filterDataModel {
    var title: String?
    var value: String?
}
class OrderFilterViewModel: BaseViewModel {
    var dataModel = [filterDataModel]()
    
    func createDataModel() {
        var dataModelArray = [filterDataModel]()
        var datamodelValue = filterDataModel()
        datamodelValue.title = "Payment Status"
        datamodelValue.value = ""
        dataModelArray.append(datamodelValue)
        datamodelValue.title = "Fulfilment Status"
        datamodelValue.value = ""
        dataModelArray.append(datamodelValue)
        datamodelValue.title = "Starting Date"
        datamodelValue.value = "YYYY-MM-dd"
        dataModelArray.append(datamodelValue)
        datamodelValue.title = "Ending Date"
        datamodelValue.value = "YYYY-MM-dd"
        dataModelArray.append(datamodelValue)
        self.dataModel = dataModelArray
        self.reloadTableView?()
    }
    
}
