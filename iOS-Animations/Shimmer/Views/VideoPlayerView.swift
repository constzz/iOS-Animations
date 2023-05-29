//
//  VideoPlayerView.swift
//  iOS-Animations
//
//  Created by Konstantin Bezzemelnyi on 10.06.2023.
//

import UIKit

final class VideoPlayerView: UIView {

  private var playButton: UIButton = {
    let button = UIButton()
    let largeConfig = UIImage.SymbolConfiguration(pointSize: 44, weight: .bold, scale: .large)
    button.setImage(.init(systemName: "play.fill", withConfiguration: largeConfig), for: .normal)
    button.tintColor = .white
    return button
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupUI()
  }

  private func setupUI() {

    backgroundColor = .gray
    layer.cornerRadius = 12

    addSubview(playButton)
    playButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      playButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      playButton.centerYAnchor.constraint(equalTo: centerYAnchor),

      playButton.widthAnchor.constraint(equalTo: widthAnchor, constant: 1 / 6),
      playButton.heightAnchor.constraint(equalTo: playButton.widthAnchor),
    ])
  }
}
