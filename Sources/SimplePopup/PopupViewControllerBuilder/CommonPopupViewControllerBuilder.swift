//
//  CommonPopupViewControllerBuilder.swift
//
//  Created by Mateusz Małek on 21/08/2019.
//  Copyright © 2019 Mateusz Małek. All rights reserved.
//

import UIKit

public struct CommonPopupViewControllerBuilder: PopupViewControllerBuilder {}

public extension CommonPopupViewControllerBuilder {
  func loading(indicator: UIActivityIndicatorView, title: UILabel? = nil) -> PopupBuilder {
    guard let title = title else {
      return stacked(views: [indicator])
    }
    return stacked(views: [indicator, title])
  }

  func message(title: UILabel, icon: UIImageView? = nil) -> PopupBuilder {
    guard let icon = icon else {
      return stacked(views: [title])
    }
    return stacked(views: [icon, title])
  }

  func stacked(views: [UIView], padding: CGFloat = 20, axis: NSLayoutConstraint.Axis = .vertical) -> PopupBuilder {
    let popupVC = UIViewController()
    let stackView = UIStackView()

    stackView.axis = axis
    stackView.spacing = padding
    stackView.isLayoutMarginsRelativeArrangement = true
    stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: padding,
                                                                 leading: padding,
                                                                 bottom: padding,
                                                                 trailing: padding)

    popupVC.view.addSubview(stackView)

    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.bindFrameToSuperview()
    stackView.bindCenterToSuperview()

    views.forEach {
      stackView.addArrangedSubview($0)
    }
    popupVC.view.translatesAutoresizingMaskIntoConstraints = false
    return popup(viewController: popupVC)
  }
}
