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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .black // цвет всей вьюшки
        
        let navigationController = UINavigationController(rootViewController: MarvelVC())
        window?.rootViewController = navigationController
        
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = .black // цвет фона навбара
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red,
                                                                 NSAttributedString.Key.font: UIFont(name: "marvel-regular", size: 60)!] // цвет шрифта нав бара
        return true
    }
}

