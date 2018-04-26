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
import UserNotifications
import Messages

let delegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
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
        
        /* Notification*/
        self.registerForPushNotifications(application)
        
        if getUserID().count == 0{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "Login")
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
            
            return true
        }
        return true
    }
    
  
    func registerForPushNotifications(_ application: UIApplication) {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
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
        
        var books = [Book]()

        ref.child("books").observe(.childAdded) { (snap) in
          
            let value = snap.value as! NSDictionary
            let book = Book(
                bookID: snap.key,
                bookTitle: value["book_title"]! as? String,
                bookDescription: value["bookDescription"]! as? String,
                bookLink: value["bookLink"]! as? String,
                bookPrice: value["bookPrice"]! as? Double,
                departmentID: value["dep_name"]! as? String,
                userID: value["uid"]! as? String)
            
            if excludeCurrentUSer{
                if book.userID !=  self.getUserID(){
                    books.append(book)
                }
            }else{
                if !books.contains(where: { (boook) -> Bool in
                    if book.bookID == boook.bookID{
                        return true
                    }
                    return false
                }){
                    books.append(book)

                }
                
            }
            complation(books)
        }
    }
    
    
    
    func remove_book_from_cart(_ parkName:String) {
        
        var books_cart = get_books_in_cart()
        
        if let index = books_cart.index(where: {$0 == parkName}){
            
            books_cart.remove(at: index)
            
        }
        UserDefaults.standard.set(books_cart, forKey:"favorites")
        UserDefaults.standard.synchronize()
        
        
    }
    func add_new_book_in_cart(_ books:String, sendData:Bool)  {
        
        var book_cart = get_books_in_cart()
        
        if !book_cart.contains(books) {
            book_cart.append(books)
        }
        
        UserDefaults.standard.set(book_cart, forKey:"favorites")
        UserDefaults.standard.synchronize()
        
        NotificationCenter.default.post(name: Notification.Name("FavoriteVC"), object: nil)

    }
    
    func get_books_in_cart() -> [String] {
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

