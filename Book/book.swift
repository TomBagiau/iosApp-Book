//
//  book.swift
//  Book
//
//  Created by Tom on 10/02/2022.
//

import Foundation
import FirebaseFirestoreSwift

class Book: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var author: String
    var date: String
}
