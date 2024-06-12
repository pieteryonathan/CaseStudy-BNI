//
//  StackViewHelpers.swift
//  CaseStudy-BNI
//
//  Created by Pieter Yonathan on 13/06/24.
//

import UIKit
import Foundation

class StackViewHelpers {
    
    static func getSpacerH() -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return view
    }
}
