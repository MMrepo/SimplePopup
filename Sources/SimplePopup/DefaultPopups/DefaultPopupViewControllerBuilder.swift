//
//  DefaultPopupViewControllerBuilder.swift
//
//  Created by Mateusz Małek on 21/08/2019.
//  Copyright © 2019 Mateusz Małek. All rights reserved.
//

import Foundation

public struct DefaultPopupViewControllerBuilder<Prebuilder: PopupViewControllerBuilder>: PopupViewControllerBuilder {
  public let prebuilder: Prebuilder
  public let components = Components()
  public init(prebuilder: Prebuilder) {
    self.prebuilder = prebuilder
  }
}
