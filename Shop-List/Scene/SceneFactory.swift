//
//  SceneFactory.swift
//  Shop-List
//
//  Created by Legends on 27/06/20.
//  Copyright © 2020 Legends. All rights reserved.
//

import UIKit
///         Initialise Storyboards and View controlers on this class
class SceneFactory: NSObject {
///         Initialise and Define Sotryboards
    static let shared = SceneFactory()
    private override init() {}
    
    func getMainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle:nil)
    }
}

extension SceneFactory {
///          initialize view controllers
    func getLandingScene() -> LandingScene? {
           let storyboard = self.getMainStoryboard()
           return storyboard.instantiateViewController(withIdentifier: "LandingScene") as? LandingScene
       }
    
    func getHomeScene() -> HomeScene? {
            let storyboard = self.getMainStoryboard()
            return storyboard.instantiateViewController(withIdentifier: "HomeScene") as? HomeScene
    }
    
    func getFilterScene() -> FileterScene? {
               let storyboard = self.getMainStoryboard()
               return storyboard.instantiateViewController(withIdentifier: "FileterScene") as? FileterScene
       }
}
