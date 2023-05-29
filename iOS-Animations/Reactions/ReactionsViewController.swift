//
//  ReactionsViewController.swift
//  iOS-Animations
//
//  Created by Konstantin Bezzemelnyi on 11.06.2023.
//

import UIKit

final class ReactionsViewController: UIViewController {
  private lazy var reactionsView = ReactionsView(frame: .zero)

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemGray2
    view.add(view: reactionsView, constraints: [
      reactionsView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      reactionsView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
  }
}
