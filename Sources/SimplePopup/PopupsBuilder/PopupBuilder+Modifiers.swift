//
//  PopupBuilder+Modifiers.swift
//
//  Created by Mateusz Małek on 21/08/2019.
//  Copyright © 2019 Mateusz Małek. All rights reserved.
//

import Foundation
import UIKit

public extension PopupBuilder {
  func setScreenBoundsPadding(_ padding: CGFloat) -> PopupBuilder {
    return PopupBuilder(innerViewController: innerViewController,
                        stylizers: stylizers,
                        controls: controls,
                        screenBoundsPadding: padding,
                        actionButtonsOrientation: actionButtonsOrientation,
                        separatorColor: separatorColor)
  }

  func setActionButtons(orientation: NSLayoutConstraint.Axis) -> PopupBuilder {
    return PopupBuilder(innerViewController: innerViewController,
                        stylizers: stylizers,
                        controls: controls,
                        screenBoundsPadding: screenBoundsPadding,
                        actionButtonsOrientation: orientation,
                        separatorColor: separatorColor)
  }

  func setActionButtons(separatorColor: UIColor) -> PopupBuilder {
    return PopupBuilder(innerViewController: innerViewController,
                        stylizers: stylizers,
                        controls: controls,
                        screenBoundsPadding: screenBoundsPadding,
                        actionButtonsOrientation: actionButtonsOrientation,
                        separatorColor: separatorColor)
  }

  func add(stylizer: @escaping BackgroundStylize) -> PopupBuilder {
    return PopupBuilder(innerViewController: innerViewController,
                        stylizers: stylizers + [stylizer],
                        controls: controls,
                        screenBoundsPadding: screenBoundsPadding,
                        actionButtonsOrientation: actionButtonsOrientation,
                        separatorColor: separatorColor)
  }

  func add(control: Popup.Control) -> PopupBuilder {
    return PopupBuilder(innerViewController: innerViewController,
                        stylizers: stylizers,
                        controls: controls + [control],
                        screenBoundsPadding: screenBoundsPadding,
                        actionButtonsOrientation: actionButtonsOrientation,
                        separatorColor: separatorColor)
  }

  func background(color: UIColor) -> PopupBuilder {
    let stylizer: BackgroundStylize = {
      $0.backgroundColor = color
    }
    return add(stylizer: stylizer)
  }

  func roundedCorners(radius: CGFloat = 13) -> PopupBuilder {
    let stylizer: BackgroundStylize = { $0.layer.cornerRadius = radius }
    return add(stylizer: stylizer)
  }

  func bordered(color: UIColor = .separator, width: CGFloat = 1) -> PopupBuilder {
    let stylizer: BackgroundStylize = {
      $0.layer.borderColor = color.cgColor
      $0.layer.borderWidth = width
    }
    return add(stylizer: stylizer)
  }

  func addBottomSeparator(color: UIColor = .separator, thickness: CGFloat = 1.0) -> PopupBuilder {
    let separator = UIView()
    separator.backgroundColor = color
    innerViewController.view.addSubview(separator)

    separator.translatesAutoresizingMaskIntoConstraints = false
    separator.bottomAnchor.constraint(equalTo: innerViewController.view.bottomAnchor).isActive = true
    separator.heightAnchor.constraint(equalToConstant: thickness).isActive = true
    separator.widthAnchor.constraint(equalTo: innerViewController.view.widthAnchor).isActive = true

    return self
  }

  func addButton(title: String, color: UIColor, action: @escaping (UIButton, Popup) -> Void) -> PopupBuilder {
    let button = UIButton(type: .system)
    button.setTitle(title, for: .normal)
    button.setTitleColor(color, for: .normal)
    button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    button.setContentCompressionResistancePriority(.required, for: .horizontal)
    button.setContentCompressionResistancePriority(.required, for: .vertical)

    return addButton(button, action: action)
  }

  func addButton(_ button: UIButton, action: @escaping (UIButton, Popup) -> Void) -> PopupBuilder {
    let control = Popup.Control(button: button, action: action)
    return add(control: control)
  }

  func addDismissButton(title: String, color: UIColor) -> PopupBuilder {
    return addButton(title: title, color: color, action: { $1.dismiss(animated: true) })
  }

  func addShadow(radius: CGFloat = 3,
                 color: UIColor = .systemGray,
                 opacity: Float = 1,
                 offset: CGSize = CGSize(width: 1, height: 2)) -> PopupBuilder {
    let stylizer: BackgroundStylize = {
      $0.layer.shadowOffset = offset
      $0.layer.shadowOpacity = opacity
      $0.layer.shadowRadius = radius
      $0.layer.shadowColor = color.cgColor
    }
    return add(stylizer: stylizer)
  }
}
