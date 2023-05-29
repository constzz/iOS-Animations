//
//  UIView+Shimmering.swift
//  iOS-Animations
//
//  Created by Konstantin Bezzemelnyi on 10.06.2023.
//

import UIKit

extension UIView {
  var isShimmering: Bool {
    get { shimmerLayer != nil }
    set {
      if newValue, shimmerLayer == nil {
        shimmer()
      } else {
        noShimmer()
      }
    }
  }

  private var shimmerLayer: CALayer? {
    return layer.sublayers?.first(where: { layer in layer.name == shimmerLayerName })
  }

  private var shimmerLayerName: String { "shimmerLayer" }
  private var durationMultiplier: CGFloat { 3 }
  private var delayMultiplier: CGFloat { 2 }

  private func shimmer() {
    let shimmerLayer = CAGradientLayer()
    layoutIfNeeded() // call it so next line works
    shimmerLayer.frame = bounds
    layer.masksToBounds = true
    layer.addSublayer(shimmerLayer)

    let grayness = 256.0
    shimmerLayer.colors = [
      UIColor.white.withAlphaComponent(0).cgColor,
      UIColor(red: grayness, green: grayness, blue: grayness, alpha: 0.2).cgColor,
      UIColor(red: grayness, green: grayness, blue: grayness, alpha: 0.3).cgColor,
      UIColor(red: grayness, green: grayness, blue: grayness, alpha: 0.2).cgColor,
      UIColor.white.withAlphaComponent(0).cgColor
    ]
    shimmerLayer.locations = [0, 0.3, 0.5, 0.7, 1]
    let angle = 90 * CGFloat.pi / 180
    shimmerLayer.transform = CATransform3DMakeRotation(angle, 0, 0, 1)

    let animation = CABasicAnimation(keyPath: "transform.translation.x")
    animation.fromValue = -frame.width * delayMultiplier
    animation.toValue = frame.width * delayMultiplier
    animation.repeatCount = .infinity
    animation.duration = durationMultiplier
    shimmerLayer.bounds.size.height = frame.width
    shimmerLayer.bounds.size.width = frame.height
    shimmerLayer.add(animation, forKey: "shimmerXTranslationAnimation")
  }

  private func noShimmer() {
    shimmerLayer?.removeFromSuperlayer()
  }
}

