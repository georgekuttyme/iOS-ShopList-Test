//
//  HomeScene.swift
//  Shop-List
//
//  Created by Legends on 27/06/20.
//  Copyright © 2020 Legends. All rights reserved.
//

///        Home UI managed on this class
import UIKit

class HomeScene: BaseScene {
    var presenter: HomePresenter = HomePresenter()
    @IBOutlet weak var pickupListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.delegate = self
        self.setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.presenter.fetchPickupLocation()
    }
///    UI configuration - navigation bar manged
    private func setupUI() {
        self.navigationController?.navigationBar.isHidden = false
        self.setNavigationBackButton(isHiden: true)
        self.setNavigationTitle(ConstantLabels.applicationTitle)
        self.addRightBarButton(with: "", image: Images.sortIcon, action: #selector(didTapOnSort))
    }
///    when an update data list array this method will triger
///    Reloading the tableview on here
    override func updateView() {
        if self.presenter.pickupList.count > 0 {
            self.pickupListTableView.reloadData()
        } else {
            self.showAlert(success: true, message: ConstantLabels.noData)
        }
    }
///    Method : didTapOnSort managing the clickaction for the navigation barbutton item
///    Loading the alert view controller for Loading filter options
    @objc private func didTapOnSort() {
        if let filterScene = SceneFactory.shared.getFilterScene() {
                filterScene.view.backgroundColor = UIColor.clear
                filterScene.modalPresentationStyle = .overCurrentContext
                filterScene.modalTransitionStyle = .crossDissolve
                filterScene.delegate = self
                self.navigationController?.present(filterScene, animated: true, completion: nil)
        }
    }
}
///      pickupListTableView - Delegate methods
extension HomeScene:  UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.presenter.numberOfRows(in: section)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return self.presenter.getRawHeight()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cellId = CellIdentifier.HomeTableviewCellIdentifier
            var cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? ShopListTableViewCell
            if cell == nil {
                cell = ShopListTableViewCell(style: .default, reuseIdentifier: cellId)
            }
            if let PickupDeatils = self.presenter.getShopDetails(at: indexPath) {
                cell?.injectData(shopDetails: PickupDeatils)
            }
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.didSelectTableViewCell(at: indexPath)
    }
}
///      FilterView - Delegate methods
extension HomeScene: filterDelegates {
    func didSelectFilterValues(index: Int) {
        switch index {
        case filterValues.active.rawValue:
            self.presenter.filterListByActiveLocations(isActive: true)
        case filterValues.inActive.rawValue:
           self.presenter.filterListByActiveLocations(isActive: false)
        case filterValues.distance.rawValue:
             self.presenter.filterListByShortestDistance()
        case filterValues.reset.rawValue:
            self.presenter.fetchPickupLocation()
        default:
            break
        }
    }
}
