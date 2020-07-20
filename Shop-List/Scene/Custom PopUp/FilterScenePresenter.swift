//
//  FilterScenePresenter.swift
//  Shop-List
//
//  Created by Legends on 12/07/20.
//  Copyright © 2020 Legends. All rights reserved.
//

import UIKit

class FilterScenePresenter: NSObject {
    
    let filterList: [String] = [ConstantLabels.activeLocation,ConstantLabels.inActiveLocation,ConstantLabels.distance,ConstantLabels.resetFilter]
    ///    Returing the number of Rows for the tableview section
        func numberOfRows(in section: Int) -> Int {
            return filterList.count
        }
    ///    Returing the height of Rows for the tableview section
        func getRawHeight() -> CGFloat {
            return 50
        }
    ///    Returing the data on the each section
    func getCellDetails(at indexPath: IndexPath) -> String? {
        if filterList.count > indexPath.row {
            return self.filterList[indexPath.row]
        }
        return nil
    }
    
}
