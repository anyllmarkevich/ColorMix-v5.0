//
//  hex convert.swift
//  ColorMix v4.0
//
//  Created by anyll on 7/15/19.
//  Copyright © 2019 Anyll Markevich. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hexString:String) {
        let scanner  = Scanner(string: hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color:UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return NSString(format:"#%06x", rgb) as String
    }
}
extension UIColor {
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        return getRed(&r, green: &g, blue: &b, alpha: &a) ? (r,g,b,a) : nil
    }
}
extension UIColor {
    
    /**
     Decomposes UIColor to its RGBA components
     */
    var rgbColor: RGBColor {
        get {
            var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
            self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            return RGBColor(red: red, green: green, blue: blue, alpha: alpha)
        }
    }
    
    /**
     Decomposes UIColor to its HSBA components
     */
    var hsbColor: HSBColor {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return HSBColor(hue: h, saturation: s, brightness: b, alpha: a)
    }
    
    /**
     Holds the CGFloat values of HSBA components of a color
     */
    public struct HSBColor {
        var hue: CGFloat
        var saturation: CGFloat
        var brightness: CGFloat
        var alpha: CGFloat
        
        var uiColor: UIColor {
            get {
                return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
            }
        }
    }
    
    /**
     Holds the CGFloat values of RGBA components of a color
     */
    public struct RGBColor {
        var red: CGFloat
        var green: CGFloat
        var blue: CGFloat
        var alpha: CGFloat
        
        var uiColor: UIColor {
            get {
                return UIColor(red: red, green: green, blue: blue, alpha: alpha)
            }
        }
    }
}
extension String {
    
    var length: Int {
        return count
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
}
extension String {
    var isNumeric: Bool {
        guard self.characters.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self.characters).isSubset(of: nums)
    }
    var isHex: Bool {
        var inputString = self.lowercased()
        var good = true
        if inputString[0] == "#"{
            inputString.remove(at: inputString.startIndex)
        }
        guard inputString.characters.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f"]
        good = Set(inputString.characters).isSubset(of: nums)
        return good
    }
    var isDecimal: Bool {
        var good = true
        var stringList = [String]()
        guard self.characters.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9","."]
        good = Set(self.characters).isSubset(of: nums)
        for i in self{
            stringList.append(String(i))
        }
        var count = 0
        var dec = 0
        var decFound = 0
        for i in stringList{
            if i == "." && decFound == 1{
                good = false
            }else if i == "." && decFound == 0{
                dec = count
                decFound = 1
            }
            count+=1
        }
        var preDot = ""
        var postDot = ""
        count = 0
        if good == true{
            for i in stringList{
                if count < dec{
                    preDot+=i
                }else if count > dec{
                    postDot+=i
                }
                count+=1
            }
            if preDot.isNumeric{}else{good = false}
            if postDot.isNumeric{}else{good = false}
        }
        return good
    }
}
extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    func removingDots() -> String {
        return components(separatedBy: ".").joined()
    }
}
extension UIColor {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return (red, green, blue, alpha)
    }
}
extension String{
    var isColorHex: Bool{
        var editVar = self
        if editVar[0] == "#"{
            editVar.remove(at: editVar.startIndex)
        }
        if editVar.isHex && editVar.count == 6{
            return true
        }else{return false}
    }
}
extension String{
    var hexToNum: Int?{
        if self.isHex{
            let h2 = self
            let d4 = Int(h2, radix: 16)!
            return d4
        }else{return nil}
    }
}
extension String{
    var removeProblemCharacters: String{  // remouve characters that could compromise files in saving colors file
        let originalString = self  // save the value of the string in "string".function
        var stringList = [String]()  // create a list
        for i in originalString{  // turn sting into list of sting characters
            stringList.append(String(i))
        }
        var it = 0  // iteration saver
        for i in stringList{  // for every character
            if i == "|" || i == "/"{  // if a character is problematic
                stringList.remove(at: it)  // remouve it at iteration
                it -= 1  // decrese iterations as there are fewer items now.
            }
            it += 1  // increase iterations
        }
        var returnString = ""
        for i in stringList{  // create a final clean string
            returnString += i
        }
        return returnString  // return it
    }
}
