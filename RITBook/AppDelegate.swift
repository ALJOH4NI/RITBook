//
//  AppDelegate.swift
//  RITBook
//
//  Created by Ahmed on 3/15/18.
//

import UIKit
import Firebase
import UserNotifications
import FirebaseInstanceID

let applicationDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var books:[Book] = []
    var depts:[dept] = []
    var users:[user] = []
    var ref: DatabaseReference!
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
            get_all_depts()
            get_all_books()
        
//       let auser = user(name: "khalid",
//             email: "vb.95@kahs.com")
//        let abook = Book(bookTitle: "jhagfhsgd jsdhfd",
//                         bookDescription: "jfd jhdfjhd jhdfjhd",
//                         bookLink: "https://cdn.pixabay.com/photo/2018/02/28/10/05/love-3187623_1280.jpg",
//                         bookPrice: 19.99,
//                         collage: "khalid ",
//                         userObj: auser)
//
//        books.append(abook)
        

//        FirebaseApp.configure()
        
<<<<<<< HEAD
        FirebaseApp.configure()
        ref = Database.database().reference()
=======
>>>>>>> c98cab4d0cfb7e19ba53740d1033d813f4203f51
        
//        ref = Database.database().reference()
//        ref.child("collages").observeSingleEvent(of: .value) { (snap) in
//
//            for  de in snap.children{
//                let snap = de as! DataSnapshot
//                let value = snap.value as? [String:AnyObject]
//                self.depts.append(dept(id: snap.key, name: value!["name"]! as! String))
//            }
//        }
    
        
   
        return true
    }
    
    
   
    func get_all_depts(){
        ref = Database.database().reference()
        ref.child("depts").observeSingleEvent(of: .value) { (snap) in
            for  de in snap.children{
                let snap = de as! DataSnapshot
                let value = snap.value as? [String:AnyObject]
                self.depts.append(dept(id: snap.key, name: value!["dept_name"]! as! String))
            }
        }
    }
    
    
    func get_all_books(){
        ref = Database.database().reference()
        ref.child("books").observeSingleEvent(of: .value) { (snap) in
            for  book in snap.children{
                let snap = book as! DataSnapshot
                let value = snap.value as? [String:AnyObject]
                self.books.append(
                                    Book(
                                       bookID: snap.key,
                                       bookTitle: value!["book_title"]! as? String,
                                       bookDescription: value!["bookDescription"]! as? String,
                                       bookLink: value!["bookLink"]! as? String,
                                       bookPrice: value!["bookPrice"]! as? Double,
                                       departmentID: value!["depID"]! as? String,
                                       userID: value!["uid"]! as? String)
                )
                
            }
           print(self.books)
        }
    }
    
    
    
    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

