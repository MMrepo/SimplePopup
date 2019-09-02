//
//  PopupBuilder.swift
//
//  Created by Mateusz Małek on 21/08/2019.
//  Copyright © 2019 Mateusz Małek. All rights reserved.
//

import UIKit

public struct PopupBuilder {
  public typealias BackgroundStylize = (PopupBackgroundViewStylizable) -> Void
  let innerViewController: UIViewController
  let stylizers: [BackgroundStylize]
  let controls: [Popup.Control]
  let screenBoundsPadding: CGFloat
  let actionButtonsOrientation: NSLayoutConstraint.Axis
  let separatorColor: UIColor

  public init(innerViewController: UIViewController = UIViewController(),
              stylizers: [BackgroundStylize] = [],
              controls: [Popup.Control] = [],
              screenBoundsPadding: CGFloat = 20,
              actionButtonsOrientation: NSLayoutConstraint.Axis = .horizontal,
              separatorColor: UIColor = .separator) {
    self.innerViewController = innerViewController
    self.stylizers = stylizers
    self.controls = controls
    self.screenBoundsPadding = screenBoundsPadding
    self.actionButtonsOrientation = actionButtonsOrientation
    self.separatorColor = separatorColor
  }

  public func build() -> Popup {
    return Popup(viewController: innerViewController,
                 stylizeView: { view in self.stylizers.forEach { $0(view) } },
                 controls: controls,
                 screenBoundsPadding: screenBoundsPadding,
                 actionButtonsOrientation: actionButtonsOrientation,
                 separatorColor: separatorColor)
  }
}
