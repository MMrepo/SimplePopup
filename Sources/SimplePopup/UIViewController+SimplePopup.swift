//
//  UIViewController+SimplePopup.swift
//
//  Created by Mateusz Małek on 21/08/2019.
//  Copyright © 2019 Mateusz Małek. All rights reserved.
//

import UIKit

public extension UIViewController {
  func present(popup: Popup, animated: Bool = true) {
    addChild(popup)
    view.addSubview(popup.view)
    popup.view.translatesAutoresizingMaskIntoConstraints = false
    popup.view.bindFrameToSuperview()
    popup.didMove(toParent: self)
    if animated {
      popup.view.alpha = 0
      UIView.animate(withDuration: 0.25) {
        popup.view.alpha = 1
      }
    }
  }
}

public extension Popup {
  func dismiss(animated: Bool = true) {
    if animated {
      view.alpha = 1
      UIView.animate(withDuration: 0.25, animations: { [weak self] in
        self?.view.alpha = 0
      }, completion: { [weak self] _ in
        self?.removeSelf()
      })
    } else {
      removeSelf()
    }
  }

  private func removeSelf() {
    willMove(toParent: nil)
    view.removeFromSuperview()
    removeFromParent()
  }
}

extension UIView {
  func bindFrameToSuperview(inset: CGFloat = 0) {
    guard let superview = self.superview else { return }

    translatesAutoresizingMaskIntoConstraints = false
    topAnchor.constraint(equalTo: superview.topAnchor, constant: inset).isActive = true
    bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -inset).isActive = true
    leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: inset).isActive = true
    trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -inset).isActive = true
  }

  func bindCenterToSuperview() {
    guard let superview = self.superview else { return }

    translatesAutoresizingMaskIntoConstraints = false
    centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
    centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
  }
}
