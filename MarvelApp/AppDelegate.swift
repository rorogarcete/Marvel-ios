//
//  MarvelApp
//
//  Created by Rodrigo Garcete on 4/1/19.
//  Copyright © 2019 Rodrigo Garcete . All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setInitialViewController()
        return true
    }

    func setInitialViewController(){
        let viewModel = CharactersViewModel()
        let navController = window?.rootViewController as? UINavigationController
        let rootViewController = navController?.viewControllers.first as? CharactersViewController
        
        rootViewController?.viewModel = viewModel
    }
    
}
