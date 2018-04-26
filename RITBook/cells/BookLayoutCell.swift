//
//  BookLayoutCell.swift
//  RITBook
//
//  Created by Ahmed on 4/26/18.
//

import UIKit

class BookLayoutCell: UITableViewCell {
    @IBOutlet weak var bookTitle: UILabel!
    
    @IBOutlet weak var bookPrice: UILabel!
    @IBOutlet weak var bookDesc: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func populate(book:Book){
      bookTitle.text = book.bookTitle
        bookDesc.text = book.bookDescription
        bookPrice.text = "$\(String(describing: book.bookPrice!.doubleString()))"
        let url = URL(string:book.bookLink!)
        bookImage.kf.setImage(with: url, placeholder: UIImage(named:"book_placeholder"), options: nil, progressBlock: nil, completionHandler: nil)
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
