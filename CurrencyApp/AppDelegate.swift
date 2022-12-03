//
//  AppDelegate.swift
//  CurrencyApp
//
//  Created by Soufian Hossam on 02/12/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate{

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NetworkingManager().setup()
        return true
    }
}
