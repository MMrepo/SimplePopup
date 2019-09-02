//
//  PopupBuilder+DefaultModifiers.swift
//
//  Created by Mateusz Małek on 21/08/2019.
//  Copyright © 2019 Mateusz Małek. All rights reserved.
//

import Foundation
import UIKit

public extension PopupBuilder {
  var defaultBackgroundColor: PopupBuilder {
    return background(color: .secondarySystemBackground)
  }

  var roundedCorners: PopupBuilder {
    return roundedCorners()
  }

  var bordered: PopupBuilder {
    return bordered()
  }

  var defaultBottomSeparator: PopupBuilder {
    return addBottomSeparator()
  }

  var defaultShadow: PopupBuilder {
    return addShadow()
  }
}
