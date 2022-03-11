//
//  AppDelegate.swift
//  simple movie app
//
//  Created by Abderrahman Ajid on 9/3/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let apiFetcher = APIFetcher()
        let model = MoviesListModel(apiFetcher: apiFetcher)
        let rootVC = MoviesListVC(model: model)
        self.window?.rootViewController = rootVC
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

