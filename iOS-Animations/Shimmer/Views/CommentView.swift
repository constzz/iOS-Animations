//
//  CommentView.swift
//  iOS-Animations
//
//  Created by Konstantin Bezzemelnyi on 10.06.2023.
//

import UIKit

final class CommentView: UIView {
  private lazy var avatarView: UIView = {
    let view = UIView()
    view.backgroundColor = .gray
    view.layer.cornerRadius = 18
    return view
  }()

  private(set) lazy var contentView: UIView = {
    let view = UIView()
    view.layer.cornerRadius = 8
    view.backgroundColor = .gray
    return view
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override var intrinsicContentSize: CGSize {
    return .init(width: super.intrinsicContentSize.width, height: CGFloat(44))
  }

  func setupUI() {
    avatarView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(avatarView)

    contentView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(contentView)

    NSLayoutConstraint.activate([
      avatarView.heightAnchor.constraint(equalToConstant: 36),
      avatarView.widthAnchor.constraint(equalToConstant: 36),
      avatarView.leadingAnchor.constraint(equalTo: leadingAnchor),
      avatarView.topAnchor.constraint(equalTo: topAnchor, constant: 12),

      contentView.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 16),
      contentView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
      contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
      contentView.heightAnchor.constraint(equalToConstant: 36)
    ])
  }
}
