//
//  ProfileVC.swift
//  RITBook
//
//  Created by Ahmed on 4/12/18.
//

import UIKit
import Firebase
import FirebaseAuth

class ProfileVC: UIViewController {
        var ref: DatabaseReference!
//        var userEmail:String = "guest@email.com"
//        var userName:String = "Hello Guest"
    @IBOutlet weak var profileImage: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageRounded()
        get_curent_user()
    }

    
    
    // to make the profile image rounded
    func imageRounded(){
        //profileImage.layer.cornerRadius = 20
        //profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
        profileImage.layer.borderColor = UIColor.gray.cgColor
        profileImage.layer.borderWidth = 2
    }
    
    
    @IBAction func Logout() {
        
        if applicationDelegate.getUserID().count != 0{
            applicationDelegate.removeUserID()
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Login")
            present(vc!, animated: true, completion: nil)
        }
     
    } //end of the method
    
    
    
    func get_curent_user(){
        print(applicationDelegate.getUserID())
    applicationDelegate.ref.child("users").child(applicationDelegate.getUserID()).observeSingleEvent(of: .value) { (data) in
            print(data)
        }
        
        }

} //class
