//
//  UIViewExtensions.swift
//  CaseStudy-BNI
//
//  Created by Pieter Yonathan on 12/06/24.
//

import Foundation
import UIKit

extension UIView {
    
    @discardableResult
    func addTapAction(_ target: Any, action: Selector) -> UITapGestureRecognizer {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(target, action: action)
        addGestureRecognizer(tapGesture)
        isUserInteractionEnabled = true
        return tapGesture
    }
}
