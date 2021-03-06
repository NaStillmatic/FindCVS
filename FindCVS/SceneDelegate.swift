//
//  SceneDelegate.swift
//  FindCVS
//
//  Created by HwangByungJo  on 2022/07/14.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?
  let viewModel = LocationInformationViewModel()


  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    window = UIWindow(windowScene: windowScene)
    let rootViewController = LocationInformationViewController()
//    rootViewController.bind(viewModel)
    window?.rootViewController = UINavigationController(rootViewController: rootViewController)
    window?.makeKeyAndVisible()
  }
  
}

