//
//  SimpleTableViewCell.swift
//  Shop-List
//
//  Created by Legends on 12/07/20.
//  Copyright © 2020 Legends. All rights reserved.
//

import UIKit

class SimpleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
          super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
         super.setSelected(selected, animated: animated)
         // Configure the view for the selected state
     }
    ///    integrating the data on the Tableview cells
    func injectData(filterLabel: String?) {
        titleLabel.text = filterLabel ?? ""
    }
}
