//
//  ReactionsView.swift
//  iOS-Animations
//
//  Created by Konstantin Bezzemelnyi on 11.06.2023.
//

import UIKit

final class ReactionsView: UIView {

  private lazy var stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.layer.cornerRadius = 24
    stackView.backgroundColor = .yellow.withAlphaComponent(0.2)
    stackView.layer.borderColor = UIColor.yellow.cgColor
    stackView.layer.borderWidth = 1
    return stackView
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension ReactionsView {

  func horizontalSpaceView() -> UIView {
    let view = UIView()
    view.constraint(width: 20)
    return view
  }

  func setupUI() {
    addSubview(stackView)
    stackView.pinToSuperView()

    stackView.addArrangedSubview(horizontalSpaceView())

    ["🙈", "⭐️", "❤️", "🐼", "😍", "🏆"].enumerated().forEach { index, emoji in
      let button = UIButton()

      button.titleLabel?.font = .systemFont(ofSize: 40)
      button.widthAnchor.constraint(equalToConstant: 50).isActive = true
      button.heightAnchor.constraint(equalToConstant: 50).isActive = true

      button.setTitle(emoji, for: .normal)

      button.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
      stackView.addArrangedSubview(button)

      let duration: CGFloat = 0.02

      let buttonAnimation = UIViewPropertyAnimator(
        duration: duration,
        timingParameters: UISpringTimingParameters(mass: 0.7,
                                                   stiffness: 65,
                                                   damping: 8,
                                                   initialVelocity: CGVector(dx: 0, dy: 0))
      )

      buttonAnimation.addAnimations {
        button.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
      }

      buttonAnimation.startAnimation(afterDelay: Double(index) * 0.01)
    }

    stackView.addArrangedSubview(horizontalSpaceView())
  }
}
