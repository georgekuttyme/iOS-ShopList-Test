//
//  BaseScene.swift
//  Shop-List
//
//  Created by Legends on 27/06/20.
//  Copyright © 2020 Legends. All rights reserved.
//

import UIKit

typealias AlertActionAlias = (Any?) -> Void
protocol BasePresenterDelegate: class {
    /// Method for showing progress view
    func showProgressView()
    /// Method for hiding progress view
    func hideProgressView()
    /// Method to update the view
    func updateView()
    /// Method to show alert for error or success
    func showAlert(success: Bool, message: String?)
    /// Method to reload the view (API Calls)
    func reloadView()
    /// Method to update Api Fail cases
    func didFailAPICall()
}

///     BaseScene - Defined the Parent view controller on this application
///     Commoly using method defined on this class
///     Navigation controllers and Navigation bar button items managed on this class

class BaseScene: UIViewController {
    
   override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.initializeView()
        self.initializeData()
        self.setupNavigationBar()
    }
    
    func setupNavigationBar() {
        if #available(iOS 11.0, *) {
            navigationController?.view.backgroundColor = UIColor.appWhiteColor()
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationItem.largeTitleDisplayMode = .always
            let attributes = [
                NSAttributedString.Key.foregroundColor: UIColor.appThemeColor()
                //NSAttributedString.Key.font: UIFont.appBoldFont(size: bigFontSize)
                ]
            navigationController?.navigationBar.largeTitleTextAttributes = attributes
        }
        self.navigationController?.navigationBar.tintColor = UIColor.appThemeColor()
        navigationController?.navigationBar.backItem?.titleView?.tintColor = UIColor.appThemeColor()
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.view.backgroundColor = UIColor.appWhiteColor()
    }
    func addRightBarButton(with title: String, isBordered: Bool = false, image: UIImage? = nil, action: Selector, target: Any? = nil) {
        let barButtonItem = barButton(with: title, isBordered: isBordered, image: image, action: action, target: target)
        self.navigationItem.rightBarButtonItem = barButtonItem
    }
    func addRightBarButtons(buttons: [UIBarButtonItem]) {
        self.navigationItem.rightBarButtonItems = buttons
    }
    
    func barButton(with title: String, isBordered: Bool = false, image: UIImage? = nil, action: Selector, target: Any? = nil) -> UIBarButtonItem {
        let button = UIButton.init(type: .custom)
        let titleFont = isBordered ? UIFont.appBoldFont(size: smallFontSize) : UIFont.appBoldFont(size: normalFontSize)
        let titleSize = max(40, title.sizeOfString(withFont: titleFont).width)
        button.frame = CGRect(x: 0, y: 0, width: titleSize + 10, height: 30)
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.appThemeColor(), for: .normal)
        button.setTitleColor(UIColor.appGrayColor(), for: .disabled)
        if isBordered {
            button.layer.borderWidth = 1
            button.layer.cornerRadius = 4
            button.layer.borderColor = UIColor.appThemeColor().cgColor
        }
        if let bgImage = image {
            button.setImage(bgImage, for: .normal)
        }
        button.titleLabel?.font = titleFont
        button.addTarget(target ?? self, action: action, for: .touchUpInside)
        let barButtonItem = UIBarButtonItem(customView: button)
        return barButtonItem
    }
    /// Initializes the view elements
      func initializeView() {
          // Implementation in subclass
      }

      /// Initializes the data to be used in the view
      func initializeData() {
          // Implementation in subclass
      }
    
    func setNavigationTitle(_ title: String?) {
        self.title = title
    }
    func setNavigationBackButton(isHiden: Bool?) {
        self.navigationItem.setHidesBackButton(isHiden ?? false, animated: true);
    }
}

extension BaseScene: BasePresenterDelegate {
    func didFailAPICall() {
        let alert = UIAlertController(title: ConstantLabels.alert, message:ConstantLabels.apiFail, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: ConstantLabels.cancel, style: .cancel) { _ in })
        self.present(alert, animated: true){}
    }
    
    @objc func showProgressView() {
        self.showProgress()
    }

    @objc func hideProgressView() {
        self.hideProgress()
    }

    @objc func updateView() {
        // updates the view
    }

    @objc func reloadView() {
        // reloads the view with api calls ...
    }

    @objc func showAlert(success: Bool, message: String?) {
        //updates the view
        let alert = UIAlertController(title: ConstantLabels.alert, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: ConstantLabels.cancel, style: .cancel) { _ in })
        self.present(alert, animated: true){}
    }
}
