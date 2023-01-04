//
//  BasicViewController.swift
//  AVCaptureTest
//
//  Created by JimmyHarrington on 2019/06/16.
//  Copyright © 2019 JimmyHarrington. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    // MARK: - Variables
    let bundleIdentifier: String = Bundle.main.bundleIdentifier! // bundleIdentifier
    let appName = Bundle.main.infoDictionary!["CFBundleName"] as! String // appName
    var prefFile = String() // prefFile
    var appFile = String() // appFile
    
    // MARK: - Setup
    func setup() {
        prefFile = folderPath(s: 0, name: "Preferences")
        appFile = folderPath(s: 0, name: "Application")
    }
    
    // MARK: - Functions 1: Files
    func documentPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentsDirectory = paths.first! as NSString
        return documentsDirectory as String
    }
    
    func libraryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let libraryDirectory = paths.first! as NSString
        return libraryDirectory as String
    }
    
    func folderPath(s: Int, name: String) -> String {
        if s == 0 {
            let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
            let documentsFolder = paths.first! as NSString
            let path = documentsFolder.appendingPathComponent(name)
            return path
        } else {
            let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
            let libraryFolder = paths.first! as NSString
            let path = libraryFolder.appendingPathComponent(name)
            return path
        }
    }
    
    func folderContents(path: String) -> [String] {
        let fileManager = FileManager.default
        if let filePaths = try? fileManager.contentsOfDirectory(atPath: path) {
            return filePaths
        } else {
            return []
        }
    }
    
    func componentIsHidden(path: String) -> Bool {
        let start = path.startIndex
        let end = path.index(path.endIndex, offsetBy: 1 - path.count) // going backwards from the end
        let substring = path[start..<end]
        if substring == "." {
            return true
        } else {
            return false
        }
    }
    
    func getFileName(path: String) -> String {
        let f = (path as NSString).lastPathComponent
        return f
    }
    
    func getFileNameOnly(path: String) -> String {
        let e = NSURL(fileURLWithPath: path).deletingPathExtension?.lastPathComponent
        return e!
    }
    
    func getFileExtension(path: String) -> String {
        // no dot
        let e = NSURL(fileURLWithPath: path).pathExtension
        return e!
    }
    
    func convertPathURL(path: String) -> NSURL {
        let url = NSURL(fileURLWithPath: path)
        return url
    }
    
    func emptyFolder(folderURL: URL) {
        let fileManager = FileManager.default
        let fileURLs = fileManager.enumerator(at: folderURL, includingPropertiesForKeys: nil)
        while let folderURL = fileURLs?.nextObject() {
            do {
                try fileManager.removeItem(at: folderURL as! URL)
            } catch {
                print(error)
            }
        }
    }
    
    func deviceRemainingFreeSpaceInBytes() -> Int64? {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
        guard
            let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: documentDirectory),
            let freeSize = systemAttributes[.systemFreeSize] as? NSNumber
            else {
                // something failed
                return nil
        }
        return freeSize.int64Value
    }
    // MARK: - Functions 1: Files
    
    
    // MARK: - Functions 2: String
    func isEmailValid(_ email: String) -> Bool {
        //https;//medium.com/@darthpelo/email-validation-in-swift-3-0-acfebe4d879a
        let emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func isNameValid(name: String, minNum: Int, acceptSpace: Bool) -> Bool {
        if name != "" {
            if acceptSpace {
                if name.count >= minNum {
                    return true
                } else {
                    return false
                }
            }
            else {
                if !name.contains(" ") {
                    if name.count >= minNum {
                        return true
                    } else {
                        return false
                    }
                }
                else {
                    return false
                }
            }
        }
        else {
            return false
        }
    }
    // MARK: - Functions 2: String
    
    
    // MARK: - Functions 3: Graphics
    func makeImageFromView(v: UIView, opaque: Bool) -> UIImage {
        if opaque {
            UIGraphicsBeginImageContextWithOptions(v.bounds.size, v.isOpaque, 0.0)
        }
        else {
            UIGraphicsBeginImageContextWithOptions(v.bounds.size, !v.isOpaque, 0.0)
        }
        v.drawHierarchy(in: v.bounds, afterScreenUpdates: false)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
    func convertImageBase64(image: UIImage) -> String? {
        guard let pictData = image.pngData() else {
            return nil
        }
        let strBase64: String = pictData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
        return strBase64
    }
    
    func convertBase64Image(base64String: String) -> UIImage? {
        if let pictData = Data(base64Encoded: base64String, options: Data.Base64DecodingOptions.ignoreUnknownCharacters) {
            return UIImage(data: pictData)
        } else {
            return nil
        }
    }
    // MARK: - Functions 3: Graphics
    
    
    // MARK: - Functions 5: Attributed text
    func makeRegularAttributedString(text: String, fsize: CGFloat, color: UIColor) -> NSAttributedString {
        let atext = NSMutableAttributedString(string: text)
        let font = UIFont.systemFont(ofSize: fsize)
        let range = NSMakeRange(0, text.count)
        atext.addAttributes([NSAttributedString.Key.font:font], range: range)
        atext.addAttributes([NSAttributedString.Key.foregroundColor: color], range: range)
        return atext
    }
    
    func makeSimpleAttributedString(text: String, fname: String, fsize: CGFloat, color: UIColor) -> NSAttributedString {
        let atext = NSMutableAttributedString(string: text)
        let font = UIFont.init(name: fname, size: fsize)
        //let font = UIFont.systemFontOfSize(fsize)
        let range = NSMakeRange(0, text.count)
        atext.addAttributes([NSAttributedString.Key.font:font!], range: range)
        atext.addAttributes([NSAttributedString.Key.foregroundColor: color], range: range)
        return atext
    }
    // MARK: - Functions 5: Attributed text
    
    
    // MARK: - Functions 6: Device
    func hasJailbreak() -> Bool {
        #if arch(i386) || arch(x86_64)
        return false
        #else
        let fileManager = FileManager.default
        if (fileManager.fileExists(atPath: "/private/var/lib/apt")) {
            print("Jailbroken Device")
            return true
        } else {
            print("Clean Device")
            return false
        }
        #endif
    }
    
    func isDeviceIpad() -> Bool {
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
            return true
        } else {
            return false
        }
    }
    
    func isIphoneX() -> Bool {
        if UIDevice().userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height == 2436 {
            return true
        } else {
            return false
        }
    }
    
    func isICloudContainerAvailable() -> Bool {
        if FileManager.default.ubiquityIdentityToken != nil {
            //print("iCloud Available")
            return true
        } else {
            //print("iCloud Unavailable")
            return false
        }
    }
    // MARK: - Functions 6: Device
}

