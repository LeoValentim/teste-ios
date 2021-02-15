//
//  AppDelegate.swift
//  InvestmentSimulator
//
//  Created by Leo Valentim on 10/02/21.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var mainNavigation: UINavigationController?
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        mainNavigation = UINavigationController()
        mainNavigation?.isNavigationBarHidden = true
        let viewController = SimulationFormRouter.instantiateFeature()
        mainNavigation?.pushViewController(viewController, animated: false)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = mainNavigation
        window?.makeKeyAndVisible()
        return true
    }
}
