//
//  BookDetailsView.swift
//  Book
//
//  Created by Tom on 11/02/2022.
//

import SwiftUI

struct DetailsView: View {
    let book: Book
    
    var body: some View{
        VStack{
            Text(book.title)
                .font(.title)
                .padding()
            HStack{
                Text("Written by \(book.author) in \(book.date)")
            }
        }
    }
}


