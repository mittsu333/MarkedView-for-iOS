//
//  ConversionMDFormat.swift
//  Pods
//
//  Created by mittsu on 2016/04/19.
//

import Foundation

internal class ConversionMDFormat {
    
    func escapeForText(mdText: String!) -> String {
        
        // To escape to handle \n and ' in the script
        var escText = mdText.stringByReplacingOccurrencesOfString("\n", withString: "\\n")
        escText = escText.stringByReplacingOccurrencesOfString("'", withString: "\\'")
        return escText
    }
    
    func imgToBase64(mdText: String!) -> String {
        
        let pattern = "!\\[(.*)\\]\\((.*)\\)"
        var regex: NSRegularExpression?
        do {
            regex = try NSRegularExpression(pattern: pattern, options: [])
        } catch let error as NSError {
            print(error.localizedDescription)
            regex = nil
        }
        let results = regex?.matchesInString(mdText, options: [], range: NSMakeRange(0, mdText.length))
        
        var newMdText = mdText
        for result in results! {
            let range = result.rangeAtIndex(result.numberOfRanges - 1)
            let imgPath = mdText.substringWithRange(range)
            
            if !imgPath.pathExtensionCheck || imgPath.urlPatternCheck {
                continue
            }
            let image = UIImage(named: imgPath.getFileName)!
            let imageData = UIImagePNGRepresentation(image)
            let base64String = imageData!.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
            let dataScPath = "data:image/png;base64," + base64String
            var pathOpti = dataScPath.stringByReplacingOccurrencesOfString("\n", withString: "")
            pathOpti = pathOpti.stringByReplacingOccurrencesOfString("\r", withString: "")
            
            newMdText = newMdText.stringByReplacingOccurrencesOfString(imgPath, withString: pathOpti)
        }
        
        return newMdText
    }
    
}