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
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageRounded()
        get_curent_user()
        
    }

    
    @IBAction func deleteUserAccount(_ sender: Any) {
        
        let alet = UIAlertController(title: "Worring !! " , message: "You will not be able to login again !! ", preferredStyle: .actionSheet)
        
        alet.addAction(UIAlertAction(title: "Delete Account", style: .destructive, handler: { (x) in
            
                let user = Auth.auth().currentUser
                user?.delete(completion: { (error) in
                if let error = error {
                    print("not deleted \(error)")
                } else {
                  delegate.removeUserID()
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "registration")
                  self.present(vc!, animated: true, completion: nil)
                }
            })
            
        }))
        
        alet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (emailMe) in
            
        }))
        self.present(alet, animated: true, completion: nil)
       

    }

   
    
    
    
    // to make the profile image rounded
    func imageRounded(){
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
        profileImage.layer.borderColor = UIColor.orange.cgColor
        profileImage.layer.borderWidth = 2
    }
    
    
    @IBAction func Logout() {
        
        if delegate.getUserID().count != 0{
            delegate.removeUserID()
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Login")
            present(vc!, animated: true, completion: nil)
        }
     
    } //end of the method
    
    
    
    func get_curent_user(){
    print(delegate.getUserID())
    delegate.ref.child("users").child(delegate.getUserID()).observeSingleEvent(of: .value) { (snapshot) in
        guard  snapshot.value  as? [String:Any] != nil else{
            return
        }
         let va =  snapshot.value  as! [String:Any]
                print(va["email"] as! String)
                print(va["name"] as! String)
                self.userEmail.text = va["email"] as? String
                self.username.text = va["name"] as? String
            }
        
        } // end of get_curent_user
    
} //class
