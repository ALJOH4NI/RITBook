//
//  BookCell.swift
//  RITBook
//
//  Created by Ahmed Aljohani (RIT Student) on 4/13/18.
//

import UIKit

class BookCell: UICollectionViewCell {
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookDescLabel: UILabel!
    @IBOutlet weak var deptLabel: UILabel!
    @IBOutlet weak var bookPriceLabel: UILabel!
    override func awakeFromNib() {
        
        self.layer.cornerRadius = 10.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
        
     
    }
    
    func setUP(book:Book)  {
        
        bookTitleLabel.text = book.bookTitle
        bookDescLabel.text = book.bookDescription
        deptLabel.text = book.collage
        bookPriceLabel.text = "\(String(describing: book.bookPrice!))"

        
        
    }
}
