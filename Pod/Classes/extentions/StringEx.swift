//
//  StringEx.swift
//  Pods
//
//  Created by mittsu on 2016/04/19.
//
//

import Foundation

extension String {
    
    func str2Ns() -> NSString {
        return self as NSString
    }
    
    func data2String(data: NSData) -> String {
        return String(NSString(data: data, encoding: NSUTF8StringEncoding)!)
    }
    
    func substringWithRange(range: NSRange) -> String {        
        return str2Ns().substringWithRange(range)
    }
    
    var length: Int {
        return self.characters.count
    }
    
    var pathExtension: String {
        return str2Ns().pathExtension
    }
    
    var lastPathComponent: String {
        return str2Ns().lastPathComponent
    }
    
    var urlPatternCheck: Bool {
        return str2Ns().hasPrefix("http://")
            || str2Ns().hasPrefix("https://")
    }
    
    var pathExtensionCheck: Bool {
        return str2Ns().pathExtension == "png"
            || str2Ns().pathExtension == "jpg"
            || str2Ns().pathExtension == "jpeg"
    }

}
