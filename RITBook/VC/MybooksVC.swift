//
//  MybooksVC.swift
//  RITBook
//
//  Created by Ahmed on 4/20/18.
//

import UIKit

class MybooksVC: UITableViewController {

    var myBooks:[Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Books"
        getAllBooks()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(getAllBooks),
            name: NSNotification.Name(rawValue: "myCart"),
            object: nil)
       
    }

    

    @objc func getAllBooks(){
        delegate.get_all_books(excludeCurrentUSer: false) { (book) in
            self.myBooks = book.filter({ (book) -> Bool in
                if book.userID == delegate.getUserID(){
                    return true
                }
                return false
            })
            
            self.tableView.reloadData()
            self.navigationItem.rightBarButtonItem = self.editButtonItem
        }
    }
    
    
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myBooks.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = myBooks[indexPath.row].bookTitle
        cell.detailTextLabel?.text = "$\(String(describing:  myBooks[indexPath.row].bookPrice!))"
        
        let url = URL(string:myBooks[indexPath.row].bookLink!)
        cell.imageView?.kf.setImage(with: url, placeholder: UIImage(named:"book_placeholder"), options: nil, progressBlock: nil, completionHandler: nil)
        
//        cell.imageView?.layer.cornerRadius =  35
//        cell.layer.masksToBounds = true
//        cell.imageView?.clipsToBounds = true
//        cell.layoutIfNeeded()
        
        
        return cell
    }

   //  Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let confimationTodelete = UIAlertController(title: "Are you sure want to delete \(String(describing: self.myBooks[indexPath.row].bookTitle!))", message: " After your remove your book, your book will not be seen by other users", preferredStyle: .actionSheet)
            confimationTodelete.addAction(UIAlertAction(title: "ok", style: .default, handler: { (OK) in
                // Delete the row from the data source
                delegate.ref.child("books/\(String(describing: self.myBooks[indexPath.row].bookID!))").removeValue()
                self.myBooks.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }))
            confimationTodelete.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(confimationTodelete, animated: true, completion: nil)
            
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
