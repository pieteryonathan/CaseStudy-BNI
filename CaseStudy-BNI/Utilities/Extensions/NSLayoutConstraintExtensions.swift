//
//  NSLayoutConstraintExtensions.swift
//  CaseStudy-BNI
//
//  Created by Pieter Yonathan on 12/06/24.
//

import UIKit

extension NSLayoutConstraint {
    
    static func addSubviewAndCreateArroundEqualConstraint(in view: UIView, toView: UIView, constant: CGFloat = 0) {
        toView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NSLayoutConstraint.createTopConstraint(view: view, toView: toView, constant: constant),
            NSLayoutConstraint.createRightConstraint(view: view, toView: toView, constant: constant == 0 ? constant : -constant),
            NSLayoutConstraint.createBottomConstraint(view: view, toView: toView, constant: constant == 0 ? constant : -constant),
            NSLayoutConstraint.createLeftConstraint(view: view, toView: toView, constant: constant),
        ])
    }
    
    static func pinToView(_ view: UIView, toView: UIView, insets: UIEdgeInsets = .zero, edges: UIRectEdge = .all) {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints = [NSLayoutConstraint]()
        if edges.contains(.left) {
            constraints += [view.leftAnchor.constraint(equalTo: toView.leftAnchor, constant: insets.left)]
        }
        if edges.contains(.top) {
            constraints += [view.topAnchor.constraint(equalTo: toView.topAnchor, constant: insets.top)]
        }
        if edges.contains(.right) {
            constraints += [view.rightAnchor.constraint(equalTo: toView.rightAnchor, constant: insets.right)]
        }
        if edges.contains(.bottom) {
            constraints += [view.bottomAnchor.constraint(equalTo: toView.bottomAnchor, constant: insets.bottom)]
        }
        
        NSLayoutConstraint.activate(constraints)
    }
    
    static func pinToSafeArea(_ view: UIView, toView: UIView, insets: UIEdgeInsets = .zero, edges: UIRectEdge = .all) {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints = [NSLayoutConstraint]()
        if edges.contains(.left) {
            constraints += [view.leftAnchor.constraint(equalTo: toView.safeAreaLayoutGuide.leftAnchor, constant: insets.left)]
        }
        if edges.contains(.top) {
            constraints += [view.topAnchor.constraint(equalTo: toView.safeAreaLayoutGuide.topAnchor, constant: insets.top)]
        }
        if edges.contains(.right) {
            constraints += [view.rightAnchor.constraint(equalTo: toView.safeAreaLayoutGuide.rightAnchor, constant: insets.right)]
        }
        if edges.contains(.bottom) {
            constraints += [view.bottomAnchor.constraint(equalTo: toView.safeAreaLayoutGuide.bottomAnchor, constant: insets.bottom)]
        }
        
        NSLayoutConstraint.activate(constraints)
    }
    
    static func createTopConstraint(view: UIView,
                             toView: UIView?,
                             multiplier: CGFloat = 1,
                             constant: CGFloat = 0) -> NSLayoutConstraint {
        return NSLayoutConstraint(
            item: view,
            attribute: NSLayoutConstraint.Attribute.top,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: toView,
            attribute: NSLayoutConstraint.Attribute.top,
            multiplier: multiplier,
            constant: constant
        )
    }
    
    static func createBottomConstraint(view: UIView,
                             toView: UIView?,
                             multiplier: CGFloat = 1,
                             constant: CGFloat = 0) -> NSLayoutConstraint {
        return NSLayoutConstraint(
            item: view,
            attribute: NSLayoutConstraint.Attribute.bottom,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: toView,
            attribute: NSLayoutConstraint.Attribute.bottom,
            multiplier: multiplier,
            constant: constant
        )
    }
    
    static func createLeftConstraint(view: UIView,
                             toView: UIView?,
                             multiplier: CGFloat = 1,
                             constant: CGFloat = 0) -> NSLayoutConstraint {
        return NSLayoutConstraint(
            item: view,
            attribute: NSLayoutConstraint.Attribute.left,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: toView,
            attribute: NSLayoutConstraint.Attribute.left,
            multiplier: multiplier,
            constant: constant
        )
    }
    
    static func createRightConstraint(view: UIView,
                             toView: UIView?,
                             multiplier: CGFloat = 1,
                             constant: CGFloat = 0) -> NSLayoutConstraint {
        return NSLayoutConstraint(
            item: view,
            attribute: NSLayoutConstraint.Attribute.right,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: toView,
            attribute: NSLayoutConstraint.Attribute.right,
            multiplier: multiplier,
            constant: constant
        )
    }
    
    static func createCenterXConstraint(view: UIView,
                             toView: UIView?,
                             multiplier: CGFloat = 1,
                             constant: CGFloat = 0) -> NSLayoutConstraint {
        return NSLayoutConstraint(
            item: view,
            attribute: NSLayoutConstraint.Attribute.centerX,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: toView,
            attribute: NSLayoutConstraint.Attribute.centerX,
            multiplier: multiplier,
            constant: constant
        )
    }
    
    static func createCenterYConstraint(view: UIView,
                             toView: UIView?,
                             multiplier: CGFloat = 1,
                             constant: CGFloat = 0) -> NSLayoutConstraint {
        return NSLayoutConstraint(
            item: view,
            attribute: NSLayoutConstraint.Attribute.centerY,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: toView,
            attribute: NSLayoutConstraint.Attribute.centerY,
            multiplier: multiplier,
            constant: constant
        )
    }
    
    static func createWidthConstraint(view: UIView, constant: CGFloat, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        return NSLayoutConstraint(
            item: view,
            attribute: NSLayoutConstraint.Attribute.width,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: nil,
            attribute: NSLayoutConstraint.Attribute.notAnAttribute,
            multiplier: multiplier,
            constant: constant
        )
    }
    
    static func createEqualWidthConstraint(view: UIView, toView: UIView, constant: CGFloat = 0, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        return NSLayoutConstraint(
            item: view,
            attribute: NSLayoutConstraint.Attribute.width,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: toView,
            attribute: NSLayoutConstraint.Attribute.width,
            multiplier: multiplier,
            constant: constant
        )
    }
    
    static func createHeightConstraint(view: UIView, constant: CGFloat, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        return NSLayoutConstraint(
            item: view,
            attribute: NSLayoutConstraint.Attribute.height,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: nil,
            attribute: NSLayoutConstraint.Attribute.notAnAttribute,
            multiplier: multiplier,
            constant: constant
        )
    }
    
}
