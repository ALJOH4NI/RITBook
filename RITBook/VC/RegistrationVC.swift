//
//  Registration.swift
//  RITBook
//
//  Created by Ahmed on 3/15/18.
//

import UIKit
import Firebase
import FirebaseAuth

class RegistrationVC: UIViewController, UITextFieldDelegate {
    var ref: DatabaseReference!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBAction func didPressRegister() {
        
                email.resignFirstResponder()
                password.resignFirstResponder()
        
                if ((email.text?.isEmpty)! || (password.text?.isEmpty)!){
                    
                    let alert = UIAlertController(title: "Worring!", message: "Please Enter Your Information", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default) {(action) in
                        // do someting
                    }
                    alert.addAction(okAction)
                    present(alert, animated: true, completion: nil)
        
                } else {
                   
                    // adding new user.
                    ref = Database.database().reference()
                    ref.child("users").childByAutoId().setValue(["name":name.text ,"password": password.text,"email": email.text])
                    
                    let alert = UIAlertController(title: "Sucessfual !!", message: "You just create a new account =)", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Login page", style: .default) {(action) in
                        // transfer the use to the login page.
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Login")
                        self.present(vc!, animated: true, completion: nil)
                    }
                    alert.addAction(okAction)
                    present(alert, animated: true, completion: nil)
 
                }//else
        } // end of the method
   
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        email.resignFirstResponder()
        password.resignFirstResponder()
        didPressRegister()
        return true
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        email.delegate = self
        password.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
