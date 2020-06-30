//
//  ShopListTableViewCell.swift
//  Shop-List
//
//  Created by Legends on 28/06/20.
//  Copyright © 2020 Legends. All rights reserved.
//

import UIKit

class ShopListTableViewCell: UITableViewCell {
    @IBOutlet weak var statusIcon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLabel.textColor = UIColor.appThemeColor()
        addressLabel.textColor = UIColor.appGrayColor()
        cityLabel.textColor = UIColor.appGrayColor()
        distanceLabel.textColor = UIColor.appThemeColor()
        statusIcon.tintColor = UIColor.appThemeColor()
        titleLabel.font = UIFont.appBoldFont(size: bigFontSize)
        addressLabel.font = UIFont.appRegularFont(size: normalFontSize)
        cityLabel.font = UIFont.appRegularFont(size: normalFontSize)
        distanceLabel.font = UIFont.appRegularFont(size: normalFontSize)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
///    integrating the data on the Tableview cells
    func injectData(shopDetails: ShopPickupDetails?) {
        self.titleLabel.text = shopDetails?.name
        self.addressLabel.text = shopDetails?.address ?? ""
        self.cityLabel.text = shopDetails?.city ?? ""
        self.distanceLabel.text = "\(shopDetails?.distance ?? 0) KM"
        self.statusIcon.image = (shopDetails?.active ?? true) ? Images.activeIcon : Images.inActiveIcon
    }
}
