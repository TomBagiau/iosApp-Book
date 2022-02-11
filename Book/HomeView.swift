//
//  HomeView.swift
//  Book
//
//  Created by Tom on 10/02/2022.
//


import SwiftUI


//struct SheetView: View {
//    @EnvironmentObject var model: ViewModel
//    @Binding var showSheetView: Bool
//    @State var title: String = ""
//    @State var author: String = ""
//    @State var date: String = ""
//    
//    var body: some View {
//        NavigationView {
//            VStack{
//                TextField(
//                    "Title",
//                    text: $title
//                )
//                TextField(
//                    "Author",
//                    text: $author
//                )
//                TextField(
//                    "date",
//                    text: $date
//                )
//                Button("Add"){
//                    model.addBook(title: title, author: author, date: date)
//                    self.showSheetView = false
//                }
//            }
//                .navigationBarTitle(Text("Add Book"), displayMode: .inline)
//                .navigationBarItems(trailing: Button(action: {
//                    self.showSheetView = false
//                }) {
//                    Text("Done").bold()
//                })
//        }
//    }
//}


struct HomeView: View {
    @EnvironmentObject var model: ViewModel
    @State var seeDetails = false
    @State var showSheetView = false
    
    var body: some View {
        VStack{
            if model.user != nil{
                VStack {
                    Text("Your Books")
                        NavigationView{
                            List{
                                ForEach(model.books, id: \.id) { book in
                                    HStack{
                                        NavigationLink(destination: DetailsView(book: book)) {
                                        Text(book.title)
                                        }
                                    }
                                }.onDelete(perform: model.deleteBook)
                            }
                    }
                    
                    Button(action: {
                        self.showSheetView.toggle()
                    }) {
                        Text("Add book")
                    }.sheet(isPresented: $showSheetView) {
                        SheetView(showSheetView: self.$showSheetView)
                    }
                }
            } else {
                LoginView()
            }
            if let errorMessage = model.errorMessage{
                Text(errorMessage)
                    .padding()
                    .foregroundColor(.red)
            }
        }
        .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

