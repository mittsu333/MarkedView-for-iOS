//
//  ConversionMDFormat.swift
//  Pods
//
//  Created by mittsu on 2016/04/19.
//

import Foundation

internal class ConversionMDFormat {
    
    func escapeForText(_ mdText: String!) -> String {
        
        // To escape to handle \n and ' in the script
        var escText = mdText.replacingOccurrences(of: "\n", with: "\\n")
        escText = escText.replacingOccurrences(of: "'", with: "\\'")
        return escText
    }
    
    func imgToBase64(_ mdText: String!) -> String {
        
        let pattern = "!\\[(.*)\\]\\((.*)\\)"
        var regex: NSRegularExpression?
        do {
            regex = try NSRegularExpression(pattern: pattern, options: [])
        } catch let error as NSError {
            print(error.localizedDescription)
            regex = nil
        }
        let results = regex?.matches(in: mdText, options:[], range:NSMakeRange(0, mdText.length))
        
        var newMdText = mdText
        for result in results! {
            let range = result.rangeAt(result.numberOfRanges - 1)
            let imgPath = mdText.substringWithRange(range)
            
            if !imgPath.pathExtensionCheck || imgPath.urlPatternCheck {
                continue
            }
            
            guard let path = type2Path(imgPath.pathExtension, imgPath: imgPath) else {
                continue
            }
            newMdText = newMdText?.replacingOccurrences(of: imgPath, with: path)
        }
        
        return newMdText!
    }
    
    private func type2Path(_ imgExt: String!, imgPath: String!) -> String? {
        var dataImgPath = ""
        
        if imgExt == "jpg" || imgExt == "jpeg" {
            let image = UIImage(named: imgPath)!
            let imageData = UIImageJPEGRepresentation(image, 1)
            let base64String = imageData!.base64EncodedString(options: .lineLength64Characters)
            dataImgPath = "data:image/jpg;base64," + base64String
            
        } else if imgExt == "png" {
            let image = UIImage(named: imgPath)!
            let imageData = UIImagePNGRepresentation(image)
            let base64String = imageData!.base64EncodedString(options: .lineLength64Characters)
            dataImgPath = "data:image/png;base64," + base64String            
        }
        
        if dataImgPath == "" {
            return nil

        } else {
            let pathOpti = dataImgPath.replacingOccurrences(of: "\n", with: "")
            return pathOpti.replacingOccurrences(of: "\r", with: "")
        }
    }
    
}
