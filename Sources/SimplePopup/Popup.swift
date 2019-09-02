//
//  SimplePopup.swift
//
//  Created by Mateusz Małek on 21/08/2019.
//  Copyright © 2019 Mateusz Małek. All rights reserved.
//

import UIKit

private class SeparatorView: UIView {
  override var intrinsicContentSize: CGSize {
    return CGSize(width: 1, height: 1)
  }

  static let separatorWidth: CGFloat = 1.0

  init() {
    super.init(frame: .zero)
    translatesAutoresizingMaskIntoConstraints = false
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

public final class Popup: UIViewController {
  public typealias ButtonAction = (UIButton, Popup) -> Void

  private let topView: UIView = UIView()
  private let popupView: BackgroundView = BackgroundView()
  private let bottomStackView: UIStackView
  private var controls: [Control]
  private let actionButtonsOrientation: NSLayoutConstraint.Axis
  private let stylizeView: (PopupBackgroundViewStylizable) -> Void
  private let separatorColor: UIColor

  public init(viewController: UIViewController,
              stylizeView: @escaping (PopupBackgroundViewStylizable) -> Void,
              controls: [Control],
              screenBoundsPadding: CGFloat,
              actionButtonsOrientation: NSLayoutConstraint.Axis,
              separatorColor: UIColor) {
    self.actionButtonsOrientation = actionButtonsOrientation
    self.stylizeView = stylizeView
    self.controls = controls
    self.bottomStackView = Popup.makeStackView(orientation: self.actionButtonsOrientation)
    self.separatorColor = separatorColor

    super.init(nibName: nil, bundle: nil)

    add(viewController: viewController)
    addPopupView(withScreenBoundsPadding: screenBoundsPadding)
    addTopView()
    addBottomView()
    controls.forEach { add(control: $0) }
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    stylizeView(popupView)
    popupView.contentView.layer.cornerRadius = popupView.layer.cornerRadius
  }
}

private extension Popup {
  func addPopupView(withScreenBoundsPadding padding: CGFloat) {
    view.addSubview(popupView)

    popupView.translatesAutoresizingMaskIntoConstraints = false
    popupView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    popupView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true

    popupView.widthAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.widthAnchor, constant: -padding).isActive = true
    popupView.heightAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.heightAnchor, constant: -padding).isActive = true
  }

  func addTopView() {
    popupView.contentView.addSubview(topView)
    topView.translatesAutoresizingMaskIntoConstraints = false
    topView.topAnchor.constraint(equalTo: popupView.topAnchor, constant: 0).isActive = true
    topView.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 0).isActive = true
    topView.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: 0).isActive = true
  }

  func addBottomView() {
    popupView.contentView.addSubview(bottomStackView)
    bottomStackView.translatesAutoresizingMaskIntoConstraints = false
    bottomStackView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 0).isActive = true
    bottomStackView.bottomAnchor.constraint(equalTo: popupView.bottomAnchor, constant: 0).isActive = true
    bottomStackView.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 0).isActive = true
    bottomStackView.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: 0).isActive = true
  }

  func add(viewController: UIViewController) {
    addChild(viewController)
    topView.addSubview(viewController.view)

    viewController.view.translatesAutoresizingMaskIntoConstraints = false
    viewController.view.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: 0).isActive = true
    viewController.view.topAnchor.constraint(equalTo: topView.topAnchor, constant: 0).isActive = true
    viewController.view.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 0).isActive = true
    viewController.view.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: 0).isActive = true
    viewController.didMove(toParent: self)
  }

  func actionFor(button: UIButton) throws -> ButtonAction {
    guard let action = controls.first(where: { $0.button == button })?.action else {
      throw PopupError.missingActionFor(button: button)
    }
    return action
  }

  func addSeparatorTo(button: UIButton) {
    let separatorOrientation = SeparatorOrientation(forAxisOrientation: actionButtonsOrientation)
    let separator = Popup.makeSeparator(orientation: separatorOrientation, color: separatorColor)
    button.addSubview(separator)

    switch separatorOrientation {
    case .vertical:
      separator.centerXAnchor.constraint(equalTo: button.leftAnchor).isActive = true
      separator.topAnchor.constraint(equalTo: button.topAnchor).isActive = true
      separator.bottomAnchor.constraint(equalTo: button.bottomAnchor).isActive = true
    case .horizontal:
      separator.centerYAnchor.constraint(equalTo: button.topAnchor).isActive = true
      separator.leftAnchor.constraint(equalTo: button.leftAnchor).isActive = true
      separator.rightAnchor.constraint(equalTo: button.rightAnchor).isActive = true
    }
  }
}

public extension Popup {
  class Control {
    let button: UIButton
    let action: ButtonAction

    public init(button: UIButton, action: @escaping ButtonAction) {
      self.button = button
      self.action = action
    }
  }
}

extension Popup {
  enum PopupError: Error {
    case missingActionFor(button: UIButton)
  }
}

extension Popup {
  private func add(control: Control) {
    control.button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    bottomStackView.addArrangedSubview(control.button)
    if bottomStackView.arrangedSubviews.count > 1 {
      addSeparatorTo(button: control.button)
    }
  }

  @objc private func buttonTapped(_ button: UIButton) {
    let action = try? actionFor(button: button)
    action?(button, self)
    dismiss(animated: true, completion: nil)
  }
}

private extension Popup {
  static func makeStackView(orientation: NSLayoutConstraint.Axis) -> UIStackView {
    let stackView = UIStackView()
    stackView.axis = orientation
    stackView.distribution = .fillEqually
    stackView.alignment = .fill
    return stackView
  }

  static func makeSeparator(orientation: SeparatorOrientation, color: UIColor) -> UIView {
    let view = SeparatorView()
    view.backgroundColor = color
    switch orientation {
    case .vertical:
      view.widthAnchor.constraint(equalToConstant: SeparatorView.separatorWidth).isActive = true
    case .horizontal:
      view.heightAnchor.constraint(equalToConstant: SeparatorView.separatorWidth).isActive = true
    }
    return view
  }
}

private extension Popup {
  enum SeparatorOrientation {
    case vertical
    case horizontal

    init(forAxisOrientation axisOrientation: NSLayoutConstraint.Axis) {
      switch axisOrientation {
      case .vertical:
        self = .horizontal
      case .horizontal:
        self = .vertical
      @unknown default:
        fatalError("Some new case of NSLayoutConstraint.Axis occured.")
      }
    }
  }
}
