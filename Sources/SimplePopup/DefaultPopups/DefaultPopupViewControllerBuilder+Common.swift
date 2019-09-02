//
//  DefaultPopupViewControllerBuilder+Common.swift
//
//  Created by Mateusz Małek on 21/08/2019.
//  Copyright © 2019 Mateusz Małek. All rights reserved.
//

import UIKit

public extension DefaultPopupViewControllerBuilder where Prebuilder == CommonPopupViewControllerBuilder {
  func messageScrollable(_ message: String,
                         size: CGSize,
                         textColor: UIColor = .label,
                         font: UIFont = .preferredFont(forTextStyle: .caption1),
                         icon: UIImage? = nil) -> PopupBuilder {
    let views: [UIView]
    if let iconView = components.defaultIconImageView(image: icon) {
      views = [iconView,
               components.defaultTextView(text: message,
                                          size: size,
                                          textColor: textColor,
                                          font: font)]
    } else {
      views = [components.defaultTextView(text: message,
                                          size: size,
                                          textColor: textColor,
                                          font: font)]
    }

    return prebuilder.stacked(views: views)
      .roundedCorners
      .defaultBackgroundColor
      .addBottomSeparator()
  }

  var loading: PopupBuilder {
    return loading()
  }

  func loading(title: String = "",
               textColor: UIColor = .label,
               font: UIFont = .preferredFont(forTextStyle: .caption1),
               style: UIActivityIndicatorView.Style = .large) -> PopupBuilder {
    let titleLabel = title.isEmpty ? nil : components.defaultTitleLabel(text: title,
                                                                        textColor: textColor,
                                                                        font: font)
    return prebuilder.loading(indicator: components.defaultLoadingIndicator(style: style),
                              title: titleLabel).roundedCorners.defaultBackgroundColor
  }

  func message(_ message: String,
               textColor: UIColor = .label,
               font: UIFont = .preferredFont(forTextStyle: .body),
               icon: UIImage? = nil) -> PopupBuilder {
    return prebuilder.message(title: components.defaultTitleLabel(text: message,
                                                                  textColor: textColor,
                                                                  font: font),
                              icon: components.defaultIconImageView(image: icon))
      .roundedCorners
      .defaultBackgroundColor
      .addBottomSeparator()
  }

  func info(message: String,
            textColor: UIColor = .systemBlue,
            font: UIFont = .preferredFont(forTextStyle: .caption1),
            icon: UIImage? = nil) -> PopupBuilder {
    return self.message(message, textColor: textColor, font: font, icon: icon)
  }

  func warning(message: String,
               textColor: UIColor = .systemYellow,
               font: UIFont = .preferredFont(forTextStyle: .caption1),
               icon: UIImage? = nil) -> PopupBuilder {
    return self.message(message, textColor: textColor, font: font, icon: icon)
  }

  func error(message: String,
             textColor: UIColor = .systemRed,
             font: UIFont = .preferredFont(forTextStyle: .caption1),
             icon: UIImage? = nil) -> PopupBuilder {
    return self.message(message, textColor: textColor, font: font, icon: icon)
  }
}
