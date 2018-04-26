//
//  picker.swift
//  RITBook
//
//  Created by Ahmed on 4/24/18.
//

import UIKit
import Firebase
import UserNotifications
import FirebaseInstanceID
import UserNotifications
import Messages

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        processNotification(notification)
        completionHandler(.badge)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        processNotification(response.notification)
        completionHandler()
    }
    
    private func processNotification(_ notif: UNNotification) {
        let newPost = notif.request.content.userInfo["newPost"] as? String
        if newPost == "1" {
            print("did notify the user")
        }
    }
}





extension UIView {
    @IBInspectable var BookborderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
            
        }
    }
    @IBInspectable var BookborderColor: UIColor {
        get {
            return .red
        }
        set {
           layer.borderColor = newValue.cgColor
            
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}




extension Add_booksVC:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return delegate.depts.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return delegate.depts[row].name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        guard delegate.depts.count != 0 else {
            return
        }
        depTextField.text = delegate.depts[row].name
        
    }
}


/*
 Call self.hideKeyboard() in the viewDidLoad
 
 than trying to use .resignFirstResponder()

 */
extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}
