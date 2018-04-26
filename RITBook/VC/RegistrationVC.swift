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
        
        
        
                if ((email.text?.isEmpty)! || (password.text?.isEmpty)!){
                    
                    let alert = UIAlertController(title: "Worring!", message: "Please Enter Your Information", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default) {(action) in
                        // do someting
                    }
                    alert.addAction(okAction)
                    present(alert, animated: true, completion: nil)
        
                } else {
                    
                    //let regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}"
                    let regex = "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}"
                    let isMatched = NSPredicate(format:"SELF MATCHES %@", regex).evaluate(with: password.text)
                    if(isMatched  == true) {
                        let pass = self.password.text! as String
                        print(pass)
                        
                        // adding new user.
                        Auth.auth().createUser(withEmail: email.text!, password: pass){(user,Error) in
                            if user != nil {
                            self.ref = Database.database().reference() // root refernace
                                let data =  [ "name": self.name.text!,
                                            "password": pass,
                                            "email": self.email.text!]
                                
                            self.ref.child("users").child((user?.uid)!).setValue(data)
                                let alert = UIAlertController(title: "Sucessfual !!", message: "You just create a new account =)", preferredStyle: .alert)
                                let okAction = UIAlertAction(title: "Login page", style: .default) {(action) in
                                    // transfer the use to the login page.
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Login")
                                    self.present(vc!, animated: true, completion: nil)
                                }
                                alert.addAction(okAction)
                                self.present(alert, animated: true, completion: nil)
                            } // if
                        } // createUser
                        
                        
                    }  else {
                        let alert = UIAlertController(title: "Worring!", message: "Password length is 8. One Alphabet in Password. One Special Character in Password. ", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "Ok", style: .default) {(action) in
                            // do someting
                        }
                        alert.addAction(okAction)
                        present(alert, animated: true, completion: nil)
                        self.password.text = ""
                    }
                }//else
        } // end of the method
   
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.hideKeyboard()
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
