//
//  PopupViewControllerBuilder.swift
//
//  Created by Mateusz Małek on 21/08/2019.
//  Copyright © 2019 Mateusz Małek. All rights reserved.
//

import UIKit

public protocol PopupViewControllerBuilder {}
public extension PopupViewControllerBuilder {
  func popup(viewController: UIViewController) -> PopupBuilder {
    PopupBuilder(innerViewController: viewController)
  }
}
