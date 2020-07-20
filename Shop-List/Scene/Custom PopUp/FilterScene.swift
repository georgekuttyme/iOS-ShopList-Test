//
//  FilterScene.swift
//  Shop-List
//
//  Created by Legends  on 12/07/20.
//  Copyright © 2020 Legends. All rights reserved.
//

import UIKit

protocol filterDelegates: class {
    func didSelectFilterValues(index: Int)
}

enum filterValues: Int {
    case active = 0
    case inActive
    case distance
    case reset
}

class FileterScene: BaseScene {
    var presenter: FilterScenePresenter = FilterScenePresenter()
    weak var delegate: filterDelegates?
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var filterList: UITableView!
    @IBOutlet weak var filterLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }
    func setUpUI() {
        self.filterLabel.text = ConstantLabels.sortTitle
    }
    @IBAction func btnClose(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
}
///      pickupListTableView - Delegate methods
extension FileterScene:  UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.presenter.numberOfRows(in: section)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return self.presenter.getRawHeight()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cellId = CellIdentifier.SimpleTableViewCell
            var cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? SimpleTableViewCell
            if cell == nil {
                cell = SimpleTableViewCell(style: .default, reuseIdentifier: cellId)
            }
            if let filterDetails = self.presenter.getCellDetails(at: indexPath) {
                cell?.injectData(filterLabel: filterDetails)
            }
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: false) {
            self.delegate?.didSelectFilterValues(index: indexPath.row)
        }
    }
}
