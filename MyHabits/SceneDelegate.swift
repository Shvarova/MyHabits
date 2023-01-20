//
//  SceneDelegate.swift
//  MyHabits
//
//  Created by Дина Шварова on 09.01.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = TabBarController()
        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        self.window?.viewWithTag(12)?.removeFromSuperview()
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.frame = window!.frame
        blurEffectView.tag = 12
        self.window?.addSubview(blurEffectView)
    }
}


