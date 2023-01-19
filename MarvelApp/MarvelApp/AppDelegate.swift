//
//  AppDelegate.swift
//  MarvelApp
//
//  Created by Georgiy on 17.01.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    //func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.makeKeyAndVisible()
//        window?.backgroundColor = .systemBackground
//        window?.rootViewController = MarvelVC()
//
//        return true
        
        
        
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            
            let navigationController = UINavigationController.init(rootViewController: MarvelVC())
            self.window = UIWindow.init(frame: UIScreen.main.bounds)
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.backgroundColor = .white
            navigationController.navigationBar.scrollEdgeAppearance = navigationBarAppearance
            navigationController.navigationBar.prefersLargeTitles = true
            
            return true
        }
}
