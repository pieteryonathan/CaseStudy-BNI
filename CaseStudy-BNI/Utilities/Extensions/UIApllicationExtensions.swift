//
//  UIApllicationExtensions.swift
//  CaseStudy-BNI
//
//  Created by Pieter Yonathan on 12/06/24.
//

import Foundation
import UIKit

extension UIApplication {
    
    static func getWindow() -> UIWindow {
        // make sure set the window object in AppDelegate and SceneDelegate
        return (UIApplication.shared.delegate as! AppDelegate).window!
    }
    
    public static func setRootView(_ viewController: UIViewController,
                                   options: UIView.AnimationOptions = .transitionCrossDissolve,
                                   animated: Bool = true,
                                   duration: TimeInterval = 0.3,
                                   completion: (() -> Void)? = nil) {
        let window = getWindow()
        
        guard animated else {
            window.rootViewController?.dismiss(animated: false)
            window.rootViewController = viewController
            window.makeKeyAndVisible()
            return
        }
        
        window.rootViewController?.dismiss(animated: false)
        UIView.transition(with: window, duration: duration, options: options, animations: { [weak window] in
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            window?.rootViewController = viewController
            window?.makeKeyAndVisible()
            UIView.setAnimationsEnabled(oldState)
        }) { _ in
            completion?()
        }
    }
}
