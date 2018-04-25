//
//  FavoriteVC.swift
//  RITBook
//
//  Created by Ahmed on 4/20/18.
//

import UIKit

class CartVC: UITableViewController {

    var favorites:[Book] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(setUp),
            name: NSNotification.Name(rawValue: "FavoriteVC"),
            object: nil)
        
        self.title = "My cart"
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.tableView.rowHeight = 50

        self.setUp()
        
        }
 
    
    @objc func setUp()  {
        let userFavorite = applicationDelegate.get_books_in_cart()
        favorites.removeAll()
        applicationDelegate.get_all_books(excludeCurrentUSer: false) { (books) in
            
            for id in userFavorite {
                
                if let index = books.index(where:{$0.bookID == id}){
                    
                    self.favorites.append(books[index])
                }
            }
            self.tableView.reloadData()
            
        }
    
    }


    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        applicationDelegate.ref.child("users").child(favorites[indexPath.row].userID!).observeSingleEvent(of: .value) { (snapshot) in
            
            guard  snapshot.value  as? [String:Any] != nil else{
                return
            }
            let va =  snapshot.value  as! [String:Any]
            print(va["email"] as! String)
            print(va["name"] as! String)
            let userEmail = va["email"] as? String
            let username = va["name"] as? String
            
            let alet = UIAlertController(title:self.favorites[indexPath.row].bookTitle , message: "you can contact \(username!)  by email ", preferredStyle: .actionSheet)
            
            alet.addAction(UIAlertAction(title: "Email \(String(describing: userEmail!))", style: .default, handler: { (callMe) in
                if let url = URL(string: "mailto:\(String(describing: userEmail!))") {
                    UIApplication.shared.open(url)
                }
            }))
            
            alet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (emailMe) in
                
            }))
            self.present(alet, animated: true, completion: nil)
            }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favorites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = favorites[indexPath.row].bookTitle
        cell.detailTextLabel?.text = favorites[indexPath.row].departmentID

        let url = URL(string:favorites[indexPath.row].bookLink!)
        cell.imageView?.kf.setImage(with: url, placeholder: UIImage(named:"book_placeholder"), options: nil, progressBlock: nil, completionHandler: nil)
//        cell.imageView?.frame = CGRect(x: 0, y: 0, width: 30, height: 66)
//        cell.imageView?.layer.cornerRadius =  35
//        cell.layer.masksToBounds = true
//        cell.imageView?.clipsToBounds = true
//        cell.layoutIfNeeded()
        return cell
    }


    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let book = favorites[indexPath.row]
            favorites.remove(at: indexPath.row)
            applicationDelegate.remove_book_from_cart(book.bookID!)
            tableView.deleteRows(at: [indexPath], with: .fade)
            setUp()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
