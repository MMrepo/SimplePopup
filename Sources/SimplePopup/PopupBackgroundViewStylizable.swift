//
//  PopupBackgroundViewStylizable.swift
//
//  Created by Mateusz Małek on 21/08/2019.
//  Copyright © 2019 Mateusz Małek. All rights reserved.
//

import UIKit

public protocol PopupBackgroundViewStylizable: AnyObject {
  var backgroundColor: UIColor? { get set }
  var layer: CALayer { get }
}
