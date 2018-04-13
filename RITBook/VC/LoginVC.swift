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
    
    @IBAction func loginAction(_ sender: AnyObject) {
        
        if email.text! == "" || password.text! == "" {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            
        } else {
                
            Auth.auth().signIn(withEmail: email.text!, password: password.text!) {(user,Error) in
                if user != nil {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Main")
                    self.present(vc!, animated: true, completion: nil)
                }else {
                    let alert = UIAlertController(title: "Worring!", message: "Please Enter Your Information", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default) {(action) in
                        // do someting
                    }
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
                
                
                
            }
            
        } //else
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
