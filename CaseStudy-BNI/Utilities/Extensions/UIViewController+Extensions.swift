//
//  UIViewController+Extensions.swift
//  Bali United
//
//  Created by Rifat Firdaus on 1/11/17.
//  Copyright © 2017 Suitmedia. All rights reserved.
//

import UIKit
import SVProgressHUD

extension UIViewController {
    
    static func className() -> String {
        return String(describing: self)
    }

    // MARK: - NAVBAR, STATUSBAR
    
    func setTransparentNavbar() {
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.barTintColor = .clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    // MARK: - POP, DISMISS
    
    func popToViewController(controllerClass: AnyClass) {
        if let nav = self.navigationController {
            for controller in nav.viewControllers as Array {
                if controller.isKind(of: controllerClass) {
                    self.navigationController?.popToViewController(controller, animated: true)
                    break
                }
            }
        }
    }
    
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
    
    // MARK: - SELECTOR
    
    @objc func closePressed(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func backPressed(sender: UIBarButtonItem) {
        if isModal() {
            self.dismiss(animated: true, completion: nil)
        } else {
            let _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - HELPER
    
    func createNavigationController(rootController controller: UIViewController, transparent: Bool = false, statusBarStyle: UIStatusBarStyle = .default) -> UINavigationController {
        let nav = CustomNavController(rootViewController: controller, statusBarStyle: statusBarStyle)
        nav.navigationBar.barStyle = .black
//        nav.navigationBar.tintColor = UIColor.black
        if transparent {
            nav.navigationBar.backgroundColor = nil
            nav.navigationBar.setBackgroundImage(UIImage(), for: .default)
            nav.navigationBar.shadowImage = UIImage()
            nav.navigationBar.isTranslucent = true
        } else {
            nav.navigationBar.isTranslucent = false
            nav.navigationBar.barTintColor = SMUITheme.navBar.backgroundColor
            nav.navigationBar.tintColor = SMUITheme.navBar.tintColor
        }
        return nav
    }
   
    /// embed controller pada navigationController
    ///
    /// - jika `below` is true, maka view akan ditaruh dibawah dan tidak tertutup navbar.
    ///   else maka akan tertutup navbar atau dianggap translucent.
    func embedInNav(isBarHidden: Bool = true, below: Bool = true, statusBarStyle: UIStatusBarStyle = .default) -> UINavigationController {
        let controller = self
        let nav = createNavigationController(
            rootController: controller,
            transparent: !below,
            statusBarStyle: statusBarStyle
        )
        
        // Source: https://stackoverflow.com/a/69817851/2537616
        //
        nav.modalPresentationCapturesStatusBarAppearance = true
        
        nav.isNavigationBarHidden = isBarHidden
        return nav
    }
    
    /// present controller as a modal page.
    func showModal(on target: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        let controller = self
        controller.modalPresentationStyle = .fullScreen
        // controller.modalTransitionStyle = .crossDissolve
        target.present(controller, animated: animated, completion: completion)
    }
    
    /// present controller as a modal page over currrent context
    func showModalOverContext(on target: UIViewController, completion: (() -> Void)? = nil) {
        let controller = self
        controller.modalPresentationStyle = .overCurrentContext
        // controller.modalTransitionStyle = .crossDissolve
        target.present(controller, animated: true, completion: completion)
    }
    
    /// push controller into navigation stack.
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
    
    /// push and replace navigation stack using this controller. it will be the only one root controller.
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
    
}
