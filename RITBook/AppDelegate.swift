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
    var depts:[dept] = []
    var users:[user] = []
    
    lazy var ref: DatabaseReference = Database.database().reference()
    lazy var storageRef = Storage.storage().reference()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
          FirebaseApp.configure()
        get_all_depts()

        print("getUserID",getUserID())
        if getUserID().count == 0{
        
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "Login")
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
            
            return true
        }
      
        

   
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
    
    func setUserID(uID:String) {
        UserDefaults.standard.set(uID, forKey: "userID")
        UserDefaults.standard.synchronize()
    }
    func getUserID() -> String {
        if let user = UserDefaults.standard.value(forKey: "userID"){
            return (user as? String)!
        }
        return ""
    }
    func removeUserID() {
        UserDefaults.standard.removeObject(forKey: "userID")
          UserDefaults.standard.synchronize()
        
    }
    func get_all_books(excludeCurrentUSer:Bool, complation:@escaping (([Book])-> Void)){


        
        ref.child("books").observeSingleEvent(of: .value) { (snap) in
            var books = [Book]()
            for  book in snap.children{
                let snap = book as! DataSnapshot
                let value = snap.value as? [String:AnyObject]
                let book = Book(
                    bookID: snap.key,
                    bookTitle: value!["book_title"]! as? String,
                    bookDescription: value!["bookDescription"]! as? String,
                    bookLink: value!["bookLink"]! as? String,
                    bookPrice: value!["bookPrice"]! as? Double,
                    departmentID: value!["dep_name"]! as? String,
                    userID: value!["uid"]! as? String)
                
                if excludeCurrentUSer{
                    if book.userID !=  self.getUserID(){
                       books.append(book)
                    }
                }else{
                    books.append(book)

                }
        
         
                
            }
            complation(books)
        }
    }
    
    
    
    func removeFavoritePark(_ parkName:String) {
        
        var favorites = getFavoriteParks()
        
        if let index = favorites.index(where: {$0 == parkName}){
            
            favorites.remove(at: index)
            
        }
        UserDefaults.standard.set(favorites, forKey:"favorites")
        UserDefaults.standard.synchronize()
        
        
    }
    func addNewFavoritePark(_ parkName:String, sendData:Bool)  {
        
        var favorites = getFavoriteParks()
        
        if !favorites.contains(parkName) {
            favorites.append(parkName)
        }
        
        UserDefaults.standard.set(favorites, forKey:"favorites")
        
        UserDefaults.standard.synchronize()
        
 
        
    }
    
    func getFavoriteParks() -> [String] {
        guard UserDefaults.standard.array(forKey: "favorites") as? [String] != nil else {
            return []
        }
        
        return (UserDefaults.standard.array(forKey: "favorites") as? [String])!
        
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

