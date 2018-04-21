//
//  BookVC.swift
//  RITBook
//
//  Created by Ahmed Aljohani (RIT Student) on 4/13/18.
//

import UIKit
import DropDown
import NVActivityIndicatorView
private let reuseIdentifier = "Cell"

class BookVC: UICollectionViewController, UICollectionViewDelegateFlowLayout, NVActivityIndicatorViewable {
    
    @IBOutlet weak var DropFilter: UIBarButtonItem!
    let rightBarDropDown = DropDown()


    
    
    var books = [Book]()
    var booksfiltred = [Book]()
    var dropViewSelectedIndex = 0
    lazy var activityIndicatorView = NVActivityIndicatorView(frame:  CGRect(x: 0, y: 100, width: 50, height: 50),
                                                             type: NVActivityIndicatorType.ballBeat)
    fileprivate func filteredBook(_ index: Index) {
        self.booksfiltred =   self.books.filter({ (book) -> Bool in
            
            if index == 0 {
                return true
            }
            if book.departmentID == self.rightBarDropDown.dataSource[index]{
                return true
                
            }
            return false
        })
    }
    
    @IBAction func didPressDropFilter(_ sender: Any) {
        rightBarDropDown.show()
        
        rightBarDropDown.selectionAction =   { (index, item) in
          
            self.dropViewSelectedIndex = index
            self.filteredBook(index)

            self.collectionView?.reloadData()
            
        
            
        }
        
        
    }
    func setupRightBarDropDown() {
        rightBarDropDown.anchorView = DropFilter
        // You can also use localizationKeysDataSource instead. Check the docs.
        rightBarDropDown.dataSource.append("All")

        for abook in books{
            
            if !rightBarDropDown.dataSource.contains(where: {$0 ==  abook.departmentID!}){
                rightBarDropDown.dataSource.append(abook.departmentID!)

            }
        }
      
    }
    
    func reloadDta() {
        let size = CGSize(width: 30, height: 30)
        
        startAnimating(size, message: "fetching...", type: NVActivityIndicatorType.ballClipRotate)
        applicationDelegate.get_all_books(complation: { books in
            
            self.books = books
            self.collectionView?.reloadData()
            self.stopAnimating()
            self.filteredBook(self.dropViewSelectedIndex)

        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Books"
        applicationDelegate.get_all_books(complation: { books in
            
            self.books = books
            self.booksfiltred = books
            self.collectionView?.reloadData()
            self.setupRightBarDropDown()

            
        })
        activityIndicatorView.center = self.view.center

        self.view.addSubview(activityIndicatorView)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
      //  self.collectionView!.register(BookCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        collectionView?.register(UINib(nibName: "bookCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        let cellWidth : CGFloat = collectionView!.frame.size.width-15
        let cellheight : CGFloat = 367
        let cellSize = CGSize(width: cellWidth , height:cellheight)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 50, left: 1, bottom: 1, right: 1)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15 
        collectionView?.setCollectionViewLayout(layout, animated: true)
        collectionView?.reloadData()
        // Do any additional setup after loading the view.
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if (kind == UICollectionElementKindSectionHeader) {
            let headerView:UICollectionReusableView =  collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CollectionViewHeader", for: indexPath)
            
            return headerView
        }
        
        return UICollectionReusableView()
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return booksfiltred.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! BookCell
            cell.setUP(book: booksfiltred[indexPath.row])
        // Configure the cell
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        let alet = UIAlertController(title:books[indexPath.row].bookTitle , message: "you can call him by clicking button below ", preferredStyle: .actionSheet)
        
        alet.addAction(UIAlertAction(title: "Email me", style: .default, handler: { (callMe) in
            let email = "foo@bar.com"
            if let url = URL(string: "mailto:\(email)") {
                UIApplication.shared.open(url)
            }
        }))
        
    
        alet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (emailMe) in
            
        }))
        self.present(alet, animated: true, completion: nil)
    }
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
