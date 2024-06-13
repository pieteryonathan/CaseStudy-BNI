//
//  FormattingHelper.swift
//  CaseStudy-BNI
//
//  Created by Pieter Yonathan on 13/06/24.
//

import Foundation

class FormattingHelper {
    
    static func addPeriods(to number: Int) -> String {
         var numberString = String(number)
         
         var index = numberString.count - 3
         
         while index > 0 {
             numberString.insert(".", at: numberString.index(numberString.startIndex, offsetBy: index))
             index -= 3
         }
         
         return numberString
     }
}
