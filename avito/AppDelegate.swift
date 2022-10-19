//
//  AppDelegate.swift
//  avito
//
//  Created by Melanie Kofman on 17.10.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let graph = Graph()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = graph.viewController
        window?.makeKeyAndVisible()
        graph.setUpUpdate()
        return true
    }
}

