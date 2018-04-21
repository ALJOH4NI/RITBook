//
//  LoginVC.swift
//  RITBook
//
//  Created by Ahmed on 3/15/18.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginVC: UIViewController {
    var rootRef: DatabaseReference!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    fileprivate func alter_for_wrong_login() {
        let alert = UIAlertController(title: "Worring!", message: "Please Enter Your Information", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) {(action) in
            // do someting
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    fileprivate func alert_for_empty_field() {
        //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
        let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    fileprivate func main_seque() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "Main")
        applicationDelegate.window?.rootViewController = initialViewController
        applicationDelegate.window?.makeKeyAndVisible()

    }
    
    @IBAction func loginAction(_ sender: AnyObject) {
        
       
        if email.text! == "" || password.text! == "" {
            self.alert_for_empty_field()
        } else {
            Auth.auth().signIn(withEmail: email.text!, password: password.text!) {(user,Error) in
                if user != nil {
                   // save it into defaultuser
                    if let userID =  user?.uid {
                        applicationDelegate.setUserID(uID: userID)
                    }
                    self.main_seque()
                }else {
                    self.alter_for_wrong_login()
                }
            }
        } //else
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard applicationDelegate.getUserID().count == 0 else {
            
            print("he is good ", applicationDelegate.getUserID())

        
            self.main_seque()
            return
        }

        // Do any additional setup after loading the view.
    }
}
