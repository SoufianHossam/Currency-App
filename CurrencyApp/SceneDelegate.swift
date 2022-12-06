//
//  SceneDelegate.swift
//  CurrencyApp
//
//  Created by Soufian Hossam on 02/12/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = AppRouter.rootViewController
        window?.makeKeyAndVisible()
    }
}

enum AppRouter {
    static var rootViewController: UIViewController {
        let router = CurrencyConvertRouter()
        let viewController = CurrencyConverterViewController(viewModel: CurrencyConverterViewModel(),
                                                             router: router)
        router.viewController = viewController
        return viewController
    }
}
