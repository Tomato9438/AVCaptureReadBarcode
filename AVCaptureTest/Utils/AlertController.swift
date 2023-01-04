//
//  AlertController.swift
//  TokyoSubways
//
//  Created by Tom Bluewater on 11/23/16.
//  Copyright © 2016 Tom Bluewater. All rights reserved.
//

import Foundation
import UIKit

class AlertController {
    static func makeAlert(delay: Double, title: String, message: String, okayTitle: String, viewController: UIViewController) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: okayTitle, style: UIAlertAction.Style.default, handler: nil))
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    static func makeAlertCompletion(delay: Double, title: String, message: String, okayTitle: String, viewController: UIViewController, accepted: (() -> Void)?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            
            // okay button
            let defaultAction: UIAlertAction = UIAlertAction(title: okayTitle, style: UIAlertAction.Style.default, handler: {
                (action: UIAlertAction!) -> Void in accepted?()
            })
            
            alert.addAction(defaultAction)
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    static func makeCancelAlert(delay: Double, title: String, message: String, okayTitle: String, cancelTitle: String, viewController: UIViewController) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            
            // okay button
            let defaultAction: UIAlertAction = UIAlertAction(title: okayTitle, style: UIAlertAction.Style.default, handler: {
                (action: UIAlertAction!) -> Void in
                print("OK")
            })
            // cancel button
            let cancelAction: UIAlertAction = UIAlertAction(title: cancelTitle, style: UIAlertAction.Style.cancel, handler: {
                (action: UIAlertAction!) -> Void in
                print("Cancelled")
            })
            
            alert.addAction(cancelAction)
            alert.addAction(defaultAction)
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    static func alertConfirmation(delay: Double, title: String, message: String, okayTitle: String, cancelTitle: String, viewController: UIViewController,accepted: (() -> Void)? , rejected: (() -> Void)?) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            
            // okay button
            let defaultAction: UIAlertAction = UIAlertAction(title: okayTitle, style: UIAlertAction.Style.default, handler: {
                (action: UIAlertAction!) -> Void in accepted?()
            })
            // cancel button
            let cancelAction: UIAlertAction = UIAlertAction(title: cancelTitle, style: UIAlertAction.Style.cancel, handler: {
                (action: UIAlertAction!) -> Void in rejected?()
            })
            
            alert.addAction(cancelAction)
            alert.addAction(defaultAction)
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    static func alertField(delay: Double, title: String, message: String, textholder: String, okayTitle: String, cancelTitle: String, viewController: UIViewController, completion: @escaping (_ text: String?) -> Void, rejected: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        var firstTextField = UITextField()
        var textValue = ""
        alert.addTextField { (textField : UITextField!) -> Void in textField.placeholder = textholder }
        
        // okay button
        let defaultAction: UIAlertAction = UIAlertAction(title: okayTitle, style: UIAlertAction.Style.default, handler: { (action) -> Void in
            firstTextField = alert.textFields![0] as UITextField
            textValue = firstTextField.text!
            completion(textValue)
        })
        // cancel button
        let cancelAction: UIAlertAction = UIAlertAction(title: cancelTitle, style: UIAlertAction.Style.cancel, handler: {
            (action: UIAlertAction!) -> Void in rejected?()
        })
        
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func alertNumber(delay: Double, title: String, message: String, okayTitle: String, cancelTitle: String, viewController: UIViewController, completion: @escaping (_ text: String?) -> Void, rejected: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        var firstTextField = UITextField()
        var textValue = ""
        alert.addTextField { (textField : UITextField!) -> Void in textField.keyboardType = UIKeyboardType.numberPad }
        
        // okay button
        let defaultAction: UIAlertAction = UIAlertAction(title: okayTitle, style: UIAlertAction.Style.default, handler: { (action) -> Void in
            firstTextField = alert.textFields![0] as UITextField
            textValue = firstTextField.text!
            completion(textValue)
        })
        // cancel button
        let cancelAction: UIAlertAction = UIAlertAction(title: cancelTitle, style: UIAlertAction.Style.cancel, handler: {
            (action: UIAlertAction!) -> Void in rejected?()
        })
        
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func alertFieldWithDefaultText(delay: Double, title: String, message: String, defaultText: String, okayTitle: String, cancelTitle: String, hasNumPad: Bool, viewController: UIViewController, completion: @escaping (_ text: String?) -> Void, rejected: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        var firstTextField = UITextField()
        var textValue = ""
        if hasNumPad {
            alert.addTextField { (textField : UITextField!) -> Void in textField.text = defaultText;textField.keyboardType = .numberPad }
        } else {
            alert.addTextField { (textField : UITextField!) -> Void in textField.text = defaultText }
        }
        
        // okay button
        let defaultAction: UIAlertAction = UIAlertAction(title: okayTitle, style: UIAlertAction.Style.default, handler: { (action) -> Void in
            firstTextField = alert.textFields![0] as UITextField
            textValue = firstTextField.text!
            completion(textValue)
        })
        // cancel button
        let cancelAction: UIAlertAction = UIAlertAction(title: cancelTitle, style: UIAlertAction.Style.cancel, handler: {
            (action: UIAlertAction!) -> Void in rejected?()
        })
        
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func alertField2a(delay: Double, title: String, message: String, textholder0: String, textholder1: String, okayTitle: String, cancelTitle: String, viewController: UIViewController, completion: @escaping (_ text1: String?, _ text2: String?) -> Void, rejected: (() -> Void)?) {
        // no number pad option //
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        var firstTextField = UITextField()
        var secondTextField = UITextField()
        var textValue1 = ""
        var textValue2 = ""
        alert.addTextField { (textField0 : UITextField!) -> Void in textField0.placeholder = textholder0 }
        alert.addTextField { (textField1 : UITextField!) -> Void in textField1.placeholder = textholder1 }
        
        // okay button
        let defaultAction: UIAlertAction = UIAlertAction(title: okayTitle, style: UIAlertAction.Style.default, handler: { (action) -> Void in
            firstTextField = alert.textFields![0] as UITextField
            secondTextField = alert.textFields![1] as UITextField
            textValue1 = firstTextField.text!
            textValue2 = secondTextField.text!
            completion(textValue1, textValue2)
        })
        // cancel button
        let cancelAction: UIAlertAction = UIAlertAction(title: cancelTitle, style: UIAlertAction.Style.cancel, handler: {
            (action: UIAlertAction!) -> Void in rejected?()
        })
        
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func alertField2b(delay: Double, title: String, message: String, textholder0: String, textholder1: String, okayTitle: String, cancelTitle: String, hasNumPad: Bool, viewController: UIViewController, completion: @escaping (_ text1: String?, _ text2: String?) -> Void, rejected: (() -> Void)?) {
        // with number pad option //
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        var firstTextField = UITextField()
        var secondTextField = UITextField()
        var textValue1 = ""
        var textValue2 = ""
        if hasNumPad {
            alert.addTextField { (textField0 : UITextField!) -> Void in textField0.placeholder = textholder0;textField0.keyboardType = .numberPad }
            alert.addTextField { (textField1 : UITextField!) -> Void in textField1.placeholder = textholder1;textField1.keyboardType = .numberPad }
        } else {
            alert.addTextField { (textField0 : UITextField!) -> Void in textField0.placeholder = textholder0 }
            alert.addTextField { (textField1 : UITextField!) -> Void in textField1.placeholder = textholder1 }
        }
        
        // okay button
        let defaultAction: UIAlertAction = UIAlertAction(title: okayTitle, style: UIAlertAction.Style.default, handler: { (action) -> Void in
            firstTextField = alert.textFields![0] as UITextField
            secondTextField = alert.textFields![1] as UITextField
            textValue1 = firstTextField.text!
            textValue2 = secondTextField.text!
            completion(textValue1, textValue2)
        })
        // cancel button
        let cancelAction: UIAlertAction = UIAlertAction(title: cancelTitle, style: UIAlertAction.Style.cancel, handler: {
            (action: UIAlertAction!) -> Void in rejected?()
        })
        
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func alertField2c(delay: Double, title: String, message: String, textholder0: String, textholder1: String, okayTitle: String, cancelTitle: String, viewController: UIViewController, completion: @escaping (_ text1: String?, _ text2: String?) -> Void, rejected: (() -> Void)?) {
        // no number pad option + secure field for the 2nd one //
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        var firstTextField = UITextField()
        var secondTextField = UITextField()
        var textValue1 = ""
        var textValue2 = ""
        alert.addTextField { (textField0 : UITextField!) -> Void in textField0.placeholder = textholder0 }
        alert.addTextField { (textField1 : UITextField!) -> Void in textField1.placeholder = textholder1;textField1.isSecureTextEntry = true }
        
        // okay button
        let defaultAction: UIAlertAction = UIAlertAction(title: okayTitle, style: UIAlertAction.Style.default, handler: { (action) -> Void in
            firstTextField = alert.textFields![0] as UITextField
            secondTextField = alert.textFields![1] as UITextField
            textValue1 = firstTextField.text!
            textValue2 = secondTextField.text!
            completion(textValue1, textValue2)
        })
        // cancel button
        let cancelAction: UIAlertAction = UIAlertAction(title: cancelTitle, style: UIAlertAction.Style.cancel, handler: {
            (action: UIAlertAction!) -> Void in rejected?()
        })
        
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func alertField2d(delay: Double, title: String, message: String, defaultText0: String, defaultText1: String, okayTitle: String, cancelTitle: String, viewController: UIViewController, completion: @escaping (_ text1: String?, _ text2: String?) -> Void, rejected: (() -> Void)?) {
        // default values //
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        var firstTextField = UITextField()
        var secondTextField = UITextField()
        var textValue1 = ""
        var textValue2 = ""
        alert.addTextField { (textField0 : UITextField!) -> Void in textField0.text = defaultText0 }
        alert.addTextField { (textField1 : UITextField!) -> Void in textField1.text = defaultText1 }
        
        // okay button
        let defaultAction: UIAlertAction = UIAlertAction(title: okayTitle, style: UIAlertAction.Style.default, handler: { (action) -> Void in
            firstTextField = alert.textFields![0] as UITextField
            secondTextField = alert.textFields![1] as UITextField
            textValue1 = firstTextField.text!
            textValue2 = secondTextField.text!
            completion(textValue1, textValue2)
        })
        // cancel button
        let cancelAction: UIAlertAction = UIAlertAction(title: cancelTitle, style: UIAlertAction.Style.cancel, handler: {
            (action: UIAlertAction!) -> Void in rejected?()
        })
        
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func makeImageAlert(viewController: UIViewController, selfFrame: CGRect, img: UIImage, msgStr: String, canStr: String, canSelStr: String, okayStr: String, okaySelStr: String, tagInt: Int) -> Void {
        let myWidth = 260.0 as CGFloat
        let myHeight = 320.0 as CGFloat
        
        // imageView //
        let side = 128.0 as CGFloat
        let rect = CGRect.init(x: (myWidth - side)/2.0, y: 20.0, width: side, height: side)
        let imageView = UIImageView.init(frame: rect)
        imageView.backgroundColor = UIColor.lightGray
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.image = img
        
        // buttons //
        let btnColor = UIColor.init(red: 0.0, green: 0.607843, blue: 1.0, alpha: 1)
        let btnHeight = 40.0 as CGFloat
        let canRect = CGRect.init(x: 0, y: myHeight - btnHeight, width: myWidth/2, height: btnHeight)
        let okayRect = CGRect.init(x: myWidth/2, y: myHeight - btnHeight, width: myWidth/2, height: btnHeight)
        let canBtn = UIButton.init(frame: canRect)
        canBtn.setTitle(canStr, for: .normal)
        canBtn.setTitleColor(btnColor, for: .normal)
        canBtn.setTitleColor(UIColor.gray, for: .highlighted)
        let canSel = NSSelectorFromString(canSelStr)
        canBtn.addTarget(viewController, action: canSel, for:.touchUpInside)
        
        let okayBtn = UIButton.init(frame: okayRect)
        okayBtn.setTitle(okayStr, for: .normal)
        okayBtn.setTitleColor(btnColor, for: .normal)
        okayBtn.setTitleColor(UIColor.gray, for: .highlighted)
        let okaySel = NSSelectorFromString(okaySelStr)
        okayBtn.addTarget(viewController, action: okaySel, for:.touchUpInside)
        
        // msgLabel //
        let msgWidth = myWidth - 60.0 as CGFloat
        let msgHeight = 120.0 as CGFloat
        let msgRect = CGRect.init(x: (myWidth - msgWidth)/2, y: imageView.frame.origin.y + imageView.frame.size.height + 16.0, width: msgWidth, height: msgHeight)
        let msgLabel = UILabel.init(frame: msgRect)
        msgLabel.text = msgStr
        msgLabel.numberOfLines = 0
        
        // myView //
        let myRect = CGRect.init(x: (selfFrame.size.width - myWidth)/2.0, y: (selfFrame.size.height - myHeight)/2.0, width: myWidth, height: myHeight)
        let myView = UIView.init(frame: myRect)
        myView.backgroundColor = UIColor.white
        myView.addSubview(imageView)
        myView.addSubview(canBtn)
        myView.addSubview(okayBtn)
        myView.addSubview(msgLabel)
        
        myView.layer.borderColor = btnColor.cgColor
        myView.layer.cornerRadius = 12.0
        myView.layer.borderWidth = 2.0
        
        // darkView //
        let darkView = UIView.init(frame: selfFrame)
        darkView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        darkView.tag = tagInt
        darkView.addSubview(myView)
        
        // finally... //
        viewController.view.addSubview(darkView)
    }
    
    static func alertSecureField(delay: Double, title: String, message: String, defaultText: String, okayTitle: String, cancelTitle: String, hasNumPad: Bool, viewController: UIViewController, completion: @escaping (_ text: String?) -> Void, rejected: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        var firstTextField = UITextField()
        var textValue = ""
        if hasNumPad {
            alert.addTextField { (textField : UITextField!) -> Void in textField.text = defaultText;textField.keyboardType = .numberPad;textField.isSecureTextEntry = true }
        } else {
            alert.addTextField { (textField : UITextField!) -> Void in textField.text = defaultText;textField.isSecureTextEntry = true }
        }
        
        // okay button
        let defaultAction: UIAlertAction = UIAlertAction(title: okayTitle, style: UIAlertAction.Style.default, handler: { (action) -> Void in
            firstTextField = alert.textFields![0] as UITextField
            textValue = firstTextField.text!
            completion(textValue)
        })
        // cancel button
        let cancelAction: UIAlertAction = UIAlertAction(title: cancelTitle, style: UIAlertAction.Style.cancel, handler: {
            (action: UIAlertAction!) -> Void in rejected?()
        })
        
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        viewController.present(alert, animated: true, completion: nil)
    }
}


/*
http-//stackoverflow.com/questions/36241970/trouble-returning-a-string-from-alert/36242342#36242342
func showAddItemDialog(view: UIViewController, completion: @escaping (_ text: String?) -> Void ) {
    
    var firstTextField = UITextField()
    var textValue = ""
    
    let alert = UIAlertController(title: "Add Task", message: "Enter a task name", preferredStyle: .alert)
    alert.addTextField(configurationHandler: { (textField) -> Void in })
    alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) -> Void in
        firstTextField = alert.textFields![0] as UITextField
        textValue = firstTextField.text!
        completion(textValue)
    }))
    
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
        completion(nil)
    }))
    view.present(alert, animated: true, completion: nil)
}
*/

