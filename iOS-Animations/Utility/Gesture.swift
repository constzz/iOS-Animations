//
//  Gesture.swift
//  iOS-Animations
//
//  Created by Konstantin Bezzemelnyi on 12.06.2023.
//

import UIKit

public class Gesture {
  class Id {
    private var _id: UInt = 0
    public var id: UInt {
      return self._id
    }

    init() {
      self._id = UInt(bitPattern: Unmanaged.passUnretained(self).toOpaque())
    }
  }

  let id: Id

  init(id: Id) {
    self.id = id
  }

  func create() -> UIGestureRecognizer {
    preconditionFailure()
  }

  func update(gesture: UIGestureRecognizer) {
    preconditionFailure()
  }
}

// MARK: TapGesture
public extension Gesture {
  private final class TapGesture: Gesture {
    private class Impl: UITapGestureRecognizer {
      var action: () -> Void

      init(action: @escaping () -> Void) {
        self.action = action

        super.init(target: nil, action: nil)
        self.addTarget(self, action: #selector(self.onAction))
      }

      @objc private func onAction() {
        self.action()
      }
    }

    static let id = Id()

    private let action: () -> Void

    init(action: @escaping () -> Void) {
      self.action = action

      super.init(id: Self.id)
    }

    override func create() -> UIGestureRecognizer {
      return Impl(action: self.action)
    }

    override func update(gesture: UIGestureRecognizer) {
      (gesture as! Impl).action = action
    }
  }

  static func tap(_ action: @escaping () -> Void) -> Gesture {
    return TapGesture(action: action)
  }
}

// MARK: - LongPress
public extension Gesture {
  enum LongPressGestureState {
    case began
    case ended
  }

  private final class LongPressGesture: Gesture {
    private class Impl: UILongPressGestureRecognizer {
      var action: (LongPressGestureState) -> Void

      init(pressDuration: Double, action: @escaping (LongPressGestureState) -> Void) {
        self.action = action

        super.init(target: nil, action: nil)
        self.minimumPressDuration = pressDuration
        self.addTarget(self, action: #selector(self.onAction))
      }

      @objc private func onAction() {
        switch self.state {
        case .began:
          self.action(.began)
        case .ended, .cancelled:
          self.action(.ended)
        default:
          break
        }
      }
    }

    static let id = Id()

    private let pressDuration: Double
    private let action: (LongPressGestureState) -> Void

    init(pressDuration: Double, action: @escaping (LongPressGestureState) -> Void) {
      self.pressDuration = pressDuration
      self.action = action

      super.init(id: Self.id)
    }

    override func create() -> UIGestureRecognizer {
      return Impl(pressDuration: self.pressDuration, action: self.action)
    }

    override func update(gesture: UIGestureRecognizer) {
      (gesture as! Impl).minimumPressDuration = self.pressDuration
      (gesture as! Impl).action = self.action
    }
  }

  static func longPress(duration: Double = 0.2, _ action: @escaping (LongPressGestureState) -> Void) -> Gesture {
    return LongPressGesture(pressDuration: duration, action: action)
  }
}
