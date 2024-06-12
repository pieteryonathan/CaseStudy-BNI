//
//  UIStackViewExtensions.swift
//  CaseStudy-BNI
//
//  Created by Pieter Yonathan on 12/06/24.
//

import Foundation
import UIKit

// MARK: - EXTENSION UISTACKVIEW
extension UIStackView {
    
    func addArrangedSubViews(views: [UIView]) {
        views.forEach { (view) in
            self.addArrangedSubview(view)
        }
    }
    
    func insertArrangedSubview(_ view: UIView, belowArrangedSubview subview: UIView) {
        arrangedSubviews.enumerated().forEach {
            if $0.1 == subview {
                insertArrangedSubview(view, at: $0.0 + 1)
            }
        }
    }
    
    func insertArrangedSubview(_ view: UIView, aboveArrangedSubview subview: UIView) {
        arrangedSubviews.enumerated().forEach {
            if $0.1 == subview {
                insertArrangedSubview(view, at: $0.0)
            }
        }
    }
    
    func removeFully(view: UIView) {
          removeArrangedSubview(view)
          view.removeFromSuperview()
      }
      
      func removeFullyAllArrangedSubviews() {
          arrangedSubviews.forEach { (view) in
              removeFully(view: view)
          }
      }
}
