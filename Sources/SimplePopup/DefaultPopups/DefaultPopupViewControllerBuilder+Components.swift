//
//  DefaultPopupViewControllerBuilder+Components.swift
//
//  Created by Mateusz Małek on 21/08/2019.
//  Copyright © 2019 Mateusz Małek. All rights reserved.
//

import UIKit

public extension DefaultPopupViewControllerBuilder {
  struct Components {
    public init() {}

    func defaultTitleLabel(text: String,
                           textColor: UIColor = .label,
                           font: UIFont = .preferredFont(forTextStyle: .title1)) -> UILabel {
      let label = UILabel()
      label.font = font
      label.numberOfLines = 0
      label.textColor = textColor
      label.text = text
      label.adjustsFontForContentSizeCategory = true
      label.textAlignment = .center
      label.setContentCompressionResistancePriority(.required, for: .horizontal)
      label.setContentCompressionResistancePriority(.required, for: .vertical)
      label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
      label.setContentHuggingPriority(.defaultHigh, for: .vertical)

      return label
    }

    func defaultLoadingIndicator(style: UIActivityIndicatorView.Style) -> UIActivityIndicatorView {
      let indicator = UIActivityIndicatorView(style: style)
      indicator.hidesWhenStopped = true
      indicator.style = style
      indicator.startAnimating()
      return indicator
    }

    func defaultTextView(text: String,
                         size: CGSize,
                         textColor: UIColor = .label,
                         font: UIFont = .preferredFont(forTextStyle: .title1)) -> UITextView {
      let titleView = UITextView()
      titleView.font = font
      titleView.isScrollEnabled = true
      titleView.isEditable = false
      titleView.textColor = textColor
      titleView.text = text
      titleView.backgroundColor = .clear

      titleView.translatesAutoresizingMaskIntoConstraints = false
      titleView.widthAnchor.constraint(equalToConstant: size.width).isActive = true
      titleView.heightAnchor.constraint(equalToConstant: size.height).isActive = true
      return titleView
    }

    func defaultIconImageView(image: UIImage?) -> UIImageView? {
      guard let image = image else { return nil }
      return UIImageView(image: image)
    }
  }
}
