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
            
            guard let path = type2Path(imgPath.pathExtension, imgPath: imgPath) else {
                continue
            }
            newMdText = newMdText.stringByReplacingOccurrencesOfString(imgPath, withString: path)
        }
        
        return newMdText
    }
    
    private func type2Path(imgExt: String!, imgPath: String!) -> String? {
        var dataImgPath = ""
        
        if imgExt == "jpg" || imgExt == "jpeg" {
            let image = UIImage(named: imgPath)!
            let imageData = UIImageJPEGRepresentation(image, 1)
            let base64String = imageData!.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
            dataImgPath = "data:image/jpg;base64," + base64String
            
        } else if imgExt == "png" {
            let image = UIImage(named: imgPath)!
            let imageData = UIImagePNGRepresentation(image)
            let base64String = imageData!.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
            dataImgPath = "data:image/png;base64," + base64String            
        }
        
        if dataImgPath == "" {
            return nil

        } else {
            var pathOpti = dataImgPath.stringByReplacingOccurrencesOfString("\n", withString: "")
            return pathOpti.stringByReplacingOccurrencesOfString("\r", withString: "")
        }
    }
    
}