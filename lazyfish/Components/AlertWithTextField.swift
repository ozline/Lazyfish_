//
//  AlertWithTextField.swift
//  Potatoes
//
//  Created by Diego on 2021/2/25.
//

import Foundation
import UIKit
import SwiftUI

public func alertWithTextField(title: String, message: String) -> String {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    var textFieldText: String = ""
    alert.addTextField() { textField in
        textField.placeholder = "在此输入内容"
        
    }
    alert.addAction(UIAlertAction(title: "取消", style: .cancel) { _ in })
    alert.addAction(UIAlertAction(title: "确认", style: .default) {_ in
                        let textField = alert.textFields![0]
        textFieldText = textField.text ?? ""
        print( textField.text ?? "" )
    })
    showAlert(alert: alert)
    return textFieldText
}

func showAlert(alert: UIAlertController) {
    if let controller = topMostViewController() {
        controller.present(alert, animated: true)
    }
}

private func keyWindow() -> UIWindow? {
    return UIApplication.shared.connectedScenes
    .filter {$0.activationState == .foregroundActive}
    .compactMap {$0 as? UIWindowScene}
    .first?.windows.filter {$0.isKeyWindow}.first
}

private func topMostViewController() -> UIViewController? {
    guard let rootController = keyWindow()?.rootViewController else {
        return nil
    }
    return topMostViewController(for: rootController)
}

private func topMostViewController(for controller: UIViewController) -> UIViewController {
    if let presentedController = controller.presentedViewController {
        return topMostViewController(for: presentedController)
    } else if let navigationController = controller as? UINavigationController {
        guard let topController = navigationController.topViewController else {
            return navigationController
        }
        return topMostViewController(for: topController)
    } else if let tabController = controller as? UITabBarController {
        guard let topController = tabController.selectedViewController else {
            return tabController
        }
        return topMostViewController(for: topController)
    }
    return controller
}

