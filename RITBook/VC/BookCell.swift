//  BookCell.swift
//  RITBook
//
//  Created by Ahmed Aljohani (RIT Student) on 4/13/18.
//

import UIKit
import Kingfisher

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
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
        let url = URL(string:book.bookLink!)
        bookImage.kf.setImage(with: url, placeholder: UIImage(named:"book_placeholder"), options: nil, progressBlock: nil, completionHandler: nil)
        bookTitleLabel.text = book.bookTitle
        bookDescLabel.text = book.bookDescription
        deptLabel.text = book.departmentID
        let price = Double(round(1000 * book.bookPrice!)/1000)
        bookPriceLabel.text = "$\(String(price))"
  
    }
}
