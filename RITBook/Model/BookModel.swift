//
//  BookModel.swift
//  RITBook
//
//  Created by Ahmed on 4/13/18.
//

import Foundation
extension Double{
    
    func doubleString() -> String {
        return String(self)
    }
}
struct Book {
    let bookID: String?
    let bookTitle: String?
    let bookDescription: String?
    let bookLink: String?
    let bookPrice: Double?
    let departmentID: String?
    let userID: String?
}
