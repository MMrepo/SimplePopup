// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(name: "SimplePopup",
                      platforms: [.iOS(.v13)],
                      products: [.library(name: "SimplePopup",
                                          targets: ["SimplePopup"])],
                      dependencies: [],
                      targets: [.target(name: "SimplePopup",
                                        dependencies: []),
                                .testTarget(name: "SimplePopupTests",
                                            dependencies: ["SimplePopup"])])
