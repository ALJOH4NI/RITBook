//
//  MainVC.swift
//  RITBook
//
//  Created by Ahmed on 3/15/18.
//

import UIKit
import Firebase
import FirebaseAuth

class MainVC: UIViewController {

    
//    @IBAction func Logout() {
//        if Auth.auth().currentUser != nil {
//            do {
//                try Auth.auth().signOut()
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: "Login")
//                present(vc!, animated: true, completion: nil)
//            } catch let error as NSError {
//                print(error.localizedDescription)
//            }
//        }
//    } //end of the method
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let user = Auth.auth().currentUser
        if let user = user {
            let uid = user.uid
            let email = user.email
            print("uid is \(uid) and email is \(String(describing: email))")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
