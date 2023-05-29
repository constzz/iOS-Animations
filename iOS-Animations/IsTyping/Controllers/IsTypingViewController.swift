//
//  IsTypingViewController.swift
//  iOS-Animations
//
//  Created by Konstantin Bezzemelnyi on 10.06.2023.
//

import Combine
import UIKit

final class IsTypingViewController: UIViewController {
  private lazy var isTypingView = IsTypingView(frame: .zero)

  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(isTypingView)
    isTypingView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      isTypingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      isTypingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
    ])
  }
}

final class IsTypingView: UIView {
  var state: State? {
    didSet { configure() }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupUI()
  }
}

extension IsTypingView {
  struct State {}
}

private extension IsTypingView {
  func setupUI() {
    let stackView = UIStackView()
    stackView.axis = .horizontal

    addSubview(stackView)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      stackView.topAnchor.constraint(equalTo: topAnchor),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
    ])

    stackView.addArrangedSubview(makeCircle(minimumScale: 0.3,
                                            maximumScale: 0.8,
                                            delay: .zero,
                                            options: [.curveEaseIn]))

    stackView.addArrangedSubview(makeCircle(minimumScale: 0.3,
                                            maximumScale: 1.0,
                                            delay: 0.5,
                                            options: [.curveEaseInOut]))

    stackView.addArrangedSubview(makeCircle(minimumScale: 0.3,
                                            maximumScale: 0.8,
                                            delay: 1.0,
                                            options: [.curveEaseOut]))
  }

  func makeCircle(
    minimumScale: CGFloat,
    maximumScale: CGFloat,
    delay: TimeInterval,
    options: UIView.AnimationOptions
  ) -> UIView {
    let view = UIView()
    view.backgroundColor = .blue
    view.translatesAutoresizingMaskIntoConstraints = false
    view.heightAnchor.constraint(equalToConstant: 20).isActive = true
    view.widthAnchor.constraint(equalToConstant: 20).isActive = true
    view.layer.cornerRadius = 10

    view.transform = CGAffineTransform(scaleX: minimumScale, y: minimumScale)
    view.layer.opacity = 0.2

    var options = options

    options.insert(.autoreverse)
    options.insert(.repeat)
    UIView.animate(withDuration: 1.0, delay: delay, options: options) {
      view.transform = CGAffineTransform(scaleX: maximumScale, y: maximumScale)
      view.layer.opacity = 1.0
    }
    return view
  }
}

private extension IsTypingView {
  func configure() {
    guard let state else { return erase() }
  }

  func erase() {}
}
