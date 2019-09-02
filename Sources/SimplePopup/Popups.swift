//
//  Popups.swift
//
//  Created by Mateusz Małek on 21/08/2019.
//  Copyright © 2019 Mateusz Małek. All rights reserved.
//

import Foundation

public struct Popups<Builder> {
  public var get: Builder

  public init(_ builder: Builder) {
    self.get = builder
  }
}

public extension Popups where Builder == CommonPopupViewControllerBuilder {
  static var common: Popups<CommonPopupViewControllerBuilder> {
    return Popups(CommonPopupViewControllerBuilder())
  }
}

public extension Popups where Builder == DefaultPopupViewControllerBuilder<CommonPopupViewControllerBuilder> {
  static func `default`(for prebuilder: Popups<CommonPopupViewControllerBuilder>) -> DefaultPopupViewControllerBuilder<CommonPopupViewControllerBuilder> {
    return DefaultPopupViewControllerBuilder(prebuilder: prebuilder.get)
  }
}
