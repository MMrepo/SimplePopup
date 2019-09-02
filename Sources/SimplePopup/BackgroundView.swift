//
//  BackgroundView.swift
//
//  Created by Mateusz Małek on 21/08/2019.
//  Copyright © 2019 Mateusz Małek. All rights reserved.
//

import UIKit

final class BackgroundView: UIView, PopupBackgroundViewStylizable {
  let contentView = UIView()

  init() {
    super.init(frame: .zero)
    addSubview(contentView)
    contentView.clipsToBounds = true
    contentView.translatesAutoresizingMaskIntoConstraints = false
    contentView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
    contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
    contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
