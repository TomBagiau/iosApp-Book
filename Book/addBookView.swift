//
//  addBookView.swift
//  Book
//
//  Created by Tom on 11/02/2022.
//

import SwiftUI

struct SheetView: View {
    @EnvironmentObject var model: ViewModel
    @Binding var showSheetView: Bool
    @State var title: String = ""
    @State var author: String = ""
    @State var date: String = ""
    
    var body: some View {
        NavigationView {
            VStack{
                TextField(
                    "Title",
                    text: $title
                )
                    .textFieldStyle(.roundedBorder)
                    .padding()
                TextField(
                    "Author",
                    text: $author
                )
                    .textFieldStyle(.roundedBorder)
                    .padding()
                TextField(
                    "date",
                    text: $date
                )
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                Button("Add"){
                    model.addBook(title: title, author: author, date: date)
                    self.showSheetView = false
                }
            }
                .navigationBarTitle(Text("Add Book"), displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    self.showSheetView = false
                }) {
                    Text("Done").bold()
                })
        }
    }
}

