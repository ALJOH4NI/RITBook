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
    var ref: DatabaseReference!
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
            
            
            //getting the user's infromation.
            ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
                //var users = [user]() // I need to know more about this.
                
                print("snapshot.children is \(snapshot.children)")
                
                for user in snapshot.children {
                    let snap = user as! DataSnapshot
                    //   let key = snap.key
                    let value = snap.value as! [String:AnyObject]
                    
                    if value["password"]?.value == self.password.text! && value["email"]?.value == self.email.text! {
                        
                        let alert = UIAlertController(title: "Sucessfual !!", message: "You just create a new account =)", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "Login page", style: .default) {(action) in
                            // transfer the use to the login page.
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Main")
                            self.present(vc!, animated: true, completion: nil)
                        }
                        alert.addAction(okAction)
                        self.present(alert, animated: true, completion: nil)
                        
                    } else {
                        
                        let alert = UIAlertController(title: "Wrong !!", message: "Email or Password wrong", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "Login page", style: .default) {(action) in
                            // transfer the use to the login page.
                           
                        }
                        alert.addAction(okAction)
                        self.present(alert, animated: true, completion: nil)
    
                    } // inner else
                    
                    
//                    print(value["name"]!)
                }// for loop
        
            }) // end of observeSingleEvent

            
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
