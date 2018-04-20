//
//  Add_booksVC.swift
//  RITBook
//
//  Created by Mazen Alotaibi (RIT Student) on 4/12/18.
//

import UIKit
import IHKeyboardAvoiding
import Firebase
import FirebaseAuth

extension Add_booksVC:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return applicationDelegate.depts.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return applicationDelegate.depts[row].name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        guard applicationDelegate.depts.count != 0 else {
            return
        }
            print(applicationDelegate.depts[row])

        
    }
    
    
    
}
class Add_booksVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var ref: DatabaseReference!
    @IBOutlet weak var imagePicked: UIImageView!
    @IBOutlet weak var depTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet var deptPicker: UIPickerView!
    @IBAction func dissmisKeyPad(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // need to extarct the code ... refactoring
        
        
        KeyboardAvoiding.padding = -25
        KeyboardAvoiding.avoidingView = self.view
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(actionSheet(_:)))
        imagePicked.isUserInteractionEnabled = true
        imagePicked.addGestureRecognizer(tap)
        
        deptPicker.showsSelectionIndicator = true
        deptPicker.delegate = self
        deptPicker.dataSource = self
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.done, target: self, action: #selector(cancelClick))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        depTextField.inputView = deptPicker
        depTextField.inputAccessoryView = toolBar
    }

   @objc func doneClick() {
        depTextField.resignFirstResponder()
    }
     @objc func cancelClick() {
        depTextField.resignFirstResponder()
    }
    
 

    @IBAction func actionSheet(_ sender: Any) {
        print("sdskdj")
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        // 2
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.camera()
          //  println("File Deleted")
        })
        let libraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.photoLibrary()
            //println("File Saved")
        })
        
        //
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
         //   println("Cancelled")
        })
        // 4
        optionMenu.addAction(cameraAction)
        optionMenu.addAction(libraryAction)
        optionMenu.addAction(cancelAction)
        
        // 5
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    
    func camera()
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .camera
            self.present(myPickerController, animated: true, completion: nil)
        }
        
    }
    
    
    
    @IBAction func post(_ sender: Any) {
       
       //TODO
       
    }
    
    
    
//    func get_curent_user(){
//        let userID : String = (Auth.auth().currentUser?.uid)!
//        print("Current user ID is" + userID)
//        self.ref?.child("users").child(userID).observeSingleEvent(of: .value, with: {(snapshot) in
//            print(snapshot.value)
//            let userEmail = (snapshot.value as! NSDictionary)["email"] as! String
//            print(userEmail)
//            let userNmae = (snapshot.value as! NSDictionary)["name"] as! String
//            print(userNmae)
//        })
//    }
    
    
    
    func photoLibrary()
    {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .photoLibrary
            self.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePicked.contentMode = .scaleToFill
            imagePicked.image = image
        }
        dismiss(animated:true, completion: nil)
    }
    

 

}
