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

    
    
    @IBOutlet weak var profileImage: UIImageView!
    
    
    
    
    // to make the profile image rounded
    func imageRounded(){
//        profileImage.layer.cornerRadius = 20
//        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
        profileImage.layer.borderColor = UIColor.gray.cgColor
        profileImage.layer.borderWidth = 2
    }
    
    
    @IBAction func Logout() {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "Login")
                present(vc!, animated: true, completion: nil)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    } //end of the method

    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageRounded()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
