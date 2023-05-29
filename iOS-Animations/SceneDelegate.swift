//
//  SceneDelegate.swift
//  iOS-Animations
//
//  Created by Konstantin Bezzemelnyi on 29.05.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    let window = UIWindow(frame: UIScreen.main.bounds) as UIWindow
    window.windowScene = windowScene
    window.makeKeyAndVisible()

//    window.rootViewController = ShimmerViewController(nibName: nil, bundle: nil)

    let expandableSection = ExpandableSectionHeader()
    expandableSection.title = "Launch Labs"
    let controller = UIViewController()
    controller.view.add(view: expandableSection, constraints: [
      expandableSection.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor),
      expandableSection.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor),
      expandableSection.centerYAnchor.constraint(equalTo: controller.view.centerYAnchor),
    ])
    window.rootViewController = controller

    self.window = window
  }

}

