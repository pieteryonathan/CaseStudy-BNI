//
//  UIViewControllerExtensions.swift
//  CaseStudy-BNI
//
//  Created by Pieter Yonathan on 13/06/24.
//

import Foundation
import UIKit

extension UIViewController {
    
    func isModal() -> Bool {
        // Source: https://stackoverflow.com/a/43020070/2537616
        //
        if let index = navigationController?.viewControllers.firstIndex(of: self), index > 0 {
            return false
        } else if presentingViewController != nil {
            return true
        } else if navigationController?.presentingViewController?.presentedViewController == navigationController {
            return true
        } else if tabBarController?.presentingViewController is UITabBarController {
            return true
        } else {
            return false
        }
    }
    
    func popOrDismiss(animated: Bool = true) {
        if isModal() {
            dismiss(animated: animated, completion: nil)
        } else {
            let _ = navigationController?.popViewController(animated: animated)
        }
    }
    
    /// present controller as a modal page.
    func showModal(on target: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        let controller = self
        controller.modalPresentationStyle = .fullScreen
        // controller.modalTransitionStyle = .crossDissolve
        target.present(controller, animated: animated, completion: completion)
    }
    
    func push(on target: UIViewController) {
        let controller = self
        var nav: UINavigationController?
        if let target = target as? UINavigationController {
            nav = target
        } else {
            nav = target.navigationController
        }
        nav?.pushViewController(controller, animated: true)
    }
    
    func pushReplace(on target: UIViewController) {
        let controller = self
        var nav: UINavigationController?
        if let target = target as? UINavigationController {
            nav = target
        } else {
            nav = target.navigationController
        }
        nav?.pushViewController(controller, animated: true)
        nav?.viewControllers = [controller]
    }
    
    func dismissAllViewControllers() {
        var presentingViewController = self.presentingViewController
        while presentingViewController?.presentingViewController != nil {
            presentingViewController = presentingViewController?.presentingViewController
        }
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
