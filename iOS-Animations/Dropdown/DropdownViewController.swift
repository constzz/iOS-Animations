//
//  DropdownViewController.swift
//  iOS-Animations
//
//  Created by Konstantin Bezzemelnyi on 12.06.2023.
//

import UIKit

final class ExpandableSectionHeader: UIView {
  private enum Constants {
    static let titleColor = UIColor.white
    static let arrowSize = CGFloat(40)
  }

  var title: String {
    get { titleLabel.text ?? "" }
    set { titleLabel.text = newValue }
  }

  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.textColor = Constants.titleColor
    label.font = .systemFont(ofSize: 40, weight: .bold)
    return label
  }()

  private lazy var expandButton: Arrow = {
    let arrowView = Arrow(frame:
      CGRect(x: 0, y: 0, width: Constants.arrowSize, height: Constants.arrowSize)
    )
    arrowView.position = .down
    return arrowView
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }

  private func commonInit() {
    addGestureRecognizer(Gesture.tap { [weak self] in
      self?.expandButtonClickAction()
    }.create())

    addSubview(titleLabel)
    addSubview(expandButton)

    setupAutolayout()
  }

  private func setupAutolayout() {
    titleLabel.prepareForAutoLayout()
    expandButton.prepareForAutoLayout()

    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      titleLabel.topAnchor.constraint(equalTo: topAnchor),
      titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: expandButton.leadingAnchor),

      expandButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
      expandButton.trailingAnchor.constraint(equalTo: trailingAnchor),
      expandButton.heightAnchor.constraint(equalToConstant: Constants.arrowSize),
      expandButton.widthAnchor.constraint(equalToConstant: Constants.arrowSize)
    ])
  }

  // MARK: Actions

  @objc private func expandButtonClickAction(_ sender: UITapGestureRecognizer? = nil) {
    turnOverExpandButton(animated: true)

    let isExpanded = expandButton.position == .down
  }

  // MARK: Methods

  private func turnOverExpandButton(
    animated: Bool = false,
    completion: (() -> Void)? = nil
  ) {
    let turnOverBlock = { [weak self] in
      guard let self = self else { return }
      if self.expandButton.position == .up {
        self.expandButton.position = .down
      } else if self.expandButton.position == .down {
        self.expandButton.position = .up
      }
    }

    if animated {
      UIView.animate(withDuration: 0.4,
                     delay: 0,
                     usingSpringWithDamping: 0.9,
                     initialSpringVelocity: 0.1,
                     options: .curveEaseInOut,
                     animations: {
                       turnOverBlock()
                       completion?()
                     }, completion: { _ in })
    } else {
      turnOverBlock()
      completion?()
    }
  }
}

// MARK: - Arrow
enum ArrowPosition {
  case left
  case down
  case right
  case up
}

final class Arrow: UIView {
  private lazy var arrowImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = .init(systemName: "arrowtriangle.up.circle")
    imageView.contentMode = .scaleAspectFit
    imageView.tintColor = .white
    return imageView
  }()

  var position: ArrowPosition = .down {
    didSet {
      switch position {
      case .left:
        transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)

      case .down:
        transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2)

      case .right:
        transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)

      case .up:
        transform = CGAffineTransform(rotationAngle: CGFloat.pi)
      }
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(arrowImageView)
    arrowImageView.prepareForAutoLayout()

    NSLayoutConstraint.activate([
      arrowImageView.widthAnchor.constraint(equalTo: widthAnchor),
      arrowImageView.heightAnchor.constraint(equalTo: heightAnchor)
    ])
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
