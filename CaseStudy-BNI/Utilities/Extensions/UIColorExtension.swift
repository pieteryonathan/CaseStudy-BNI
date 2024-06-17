//
//  UIColor+Extension.swift
//  Bali United
//
//  Created by Rifat Firdaus on 1/12/17.
//  Copyright © 2017 Suitmedia. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0x0000FF)) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    convenience init?(hexString: String, alpha: CGFloat = 1.0) {
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
//            let hexColor = hexString.substring(from: start) //deprecated
            let hexColor = hexString[start..<hexString.endIndex]
            if hexColor.count == 6 || hexColor.count == 8 {
                let scanner = Scanner(string: String(hexColor))
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    if hexColor.count == 6 {
                        r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                        g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                        b = CGFloat((hexNumber & 0x0000ff)) / 255
                        a = alpha
                    } else {
                        r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                        g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                        b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                        a = CGFloat(hexNumber & 0x000000ff) / 255
                    }
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
    
    enum HexFormat {
        case RGB
        case ARGB
        case RGBA
        case RRGGBB
        case AARRGGBB
        case RRGGBBAA
    }

    enum HexDigits {
        case d3, d4, d6, d8
    }

    func hexString(_ format: HexFormat = .RRGGBBAA) -> String {
        let maxi = [.RGB, .ARGB, .RGBA].contains(format) ? 16 : 256

        func toI(_ f: CGFloat) -> Int {
            return min(maxi - 1, Int(CGFloat(maxi) * f))
        }

        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0

        self.getRed(&r, green: &g, blue: &b, alpha: &a)

        let ri = toI(r)
        let gi = toI(g)
        let bi = toI(b)
        let ai = toI(a)

        switch format {
        case .RGB:       return String(format: "#%X%X%X", ri, gi, bi)
        case .ARGB:      return String(format: "#%X%X%X%X", ai, ri, gi, bi)
        case .RGBA:      return String(format: "#%X%X%X%X", ri, gi, bi, ai)
        case .RRGGBB:    return String(format: "#%02X%02X%02X", ri, gi, bi)
        case .AARRGGBB:  return String(format: "#%02X%02X%02X%02X", ai, ri, gi, bi)
        case .RRGGBBAA:  return String(format: "#%02X%02X%02X%02X", ri, gi, bi, ai)
        }
    }

    func hexString(_ digits: HexDigits) -> String {
        switch digits {
        case .d3: return hexString(.RGB)
        case .d4: return hexString(.RGBA)
        case .d6: return hexString(.RRGGBB)
        case .d8: return hexString(.RRGGBBAA)
        }
    }
    
    func cssRgba() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0

        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return "rgba(\(r * 255), \(g * 255), \(b * 255), \(a))"
    }
    
    static func primary(alpha: CGFloat = 1) -> UIColor {
        return UIColor(hex: 0xd91a31, alpha: alpha)
    }
    
    static func accent(alpha: CGFloat = 1) -> UIColor {
        return UIColor(hex: 0xfcb61e, alpha: alpha)
    }
    
    static func mantis(alpha: CGFloat = 1) -> UIColor {
        return UIColor(hex: 0xfcb61e, alpha: alpha)
    }
    
    static func mediumJungleGreen() -> UIColor {
        return UIColor(hex: 0x2a2a2a)
    }
    
    static func white(alpha: CGFloat = 1) -> UIColor {
        return UIColor(hex: 0xFFFFFF, alpha: alpha)
    }
}
