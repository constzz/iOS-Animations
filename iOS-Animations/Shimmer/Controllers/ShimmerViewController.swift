//
//  ShimmerViewController.swift
//  iOS-Animations
//
//  Created by Konstantin Bezzemelnyi on 10.06.2023.
//

import UIKit

final class ShimmerViewController: UIViewController {
  private lazy var button: UIButton = {
    let button = UIButton()
    button.layer.cornerRadius = 8
    button.setTitle("Hey, Yoututbe!", for: .normal)
    button.backgroundColor = .red
    button.setTitleColor(.white, for: .normal)
    return button
  }()

  private lazy var playerView = VideoPlayerView()
  private lazy var commentsStackView = UIStackView()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white
    view.addSubview(button)
    button.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -34),
      button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      button.heightAnchor.constraint(equalToConstant: 50)
    ])

    button.isShimmering = true

    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
      self?.button.isShimmering = false
    }

    view.addSubview(playerView)
    playerView.layer.cornerRadius = 14
    playerView.layer.masksToBounds = true
    playerView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      playerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 56),
      playerView.heightAnchor.constraint(equalToConstant: 240)
    ])

    playerView.isShimmering = true

    commentsStackView.axis = .vertical
    commentsStackView.distribution = .fillProportionally
    commentsStackView.spacing = 5
    view.addSubview(commentsStackView)
    commentsStackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      commentsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      commentsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      commentsStackView.topAnchor.constraint(equalTo: playerView.bottomAnchor, constant: 16),
      commentsStackView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: 16)
    ])

    for _ in 1 ... 5 {
      let commentView = CommentView(frame: .zero)
      commentsStackView.addArrangedSubview(commentView)
      commentView.contentView.isShimmering = true
    }
  }
}

