//
//  LandingScene.swift
//  Shop-List
//
//  Created by Legends on 27/06/20.
//  Copyright © 2020 Legends. All rights reserved.
//

import UIKit

class LandingScene: UIViewController {
///    configure the application on this View
///    Load default values
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LocationManager.shared.initLocationManager()
        self.setupScene()
    }
    override func viewDidAppear(_ animated: Bool) {
        self.gotoHomeScene()
    }
    
///    configure application launch view UI
    func setupScene() {
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor.appThemeColor()
    }
    
///    Navigate to Home screen
    func gotoHomeScene() {
        if let homeScene = SceneFactory.shared.getHomeScene() {
            homeScene.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(homeScene, animated: false)
        }
    }
}
