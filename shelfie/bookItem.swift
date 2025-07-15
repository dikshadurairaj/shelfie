//
//  bookItem.swift
//  shelfie
//
//  Created by Grace Shen on 2025-07-15.
//

import Foundation

class bookItem {
    var title: String
    var rating: Float
    var review: String
    var status: String
    
    init(title: String, rating: Float, review: String, status: String) {
        self.title = title
        self.rating = rating
        self.review = review
        self.status = status
    }
}
