//
//  ViewModel.swift
//  Book
//
//  Created by Tom on 10/02/2022.
//


import Foundation
import Combine
import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift


class ViewModel: ObservableObject {
    @Published var user: User?
    @Published var errorMessage: String?
    @Published var books = [Book]()
    
    var listener: ListenerRegistration?
    var subscription: AnyCancellable?
    
    var db = Firestore.firestore()
    
    init() {
        subscription = $user.sink(receiveValue: { [weak self] user in
            self?.setListener(user: user)
        })
    }
}


// Firebase management
extension ViewModel {
    @MainActor
    
    func login(mail: String, password: String) {
        Task {
            do {
                let authResult = try await Auth.auth().signIn(withEmail: mail, password: password)
                errorMessage = .none
                user = authResult.user
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            errorMessage = .none
            user = .none
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func snapshotListener(querySnapshot: QuerySnapshot?, error: Error?) {
        if let error = error {
            errorMessage = error.localizedDescription
        }
        
        if let documents = querySnapshot?.documents {
            print("Documents: \(documents)")
            do {
                books = try documents.compactMap({ document /* -> Book? */ in
                    let book = try document.data(as: Book.self)
                    return book
               })
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
    
    func addBook(title: String, author: String, date: String){
        var ref: DocumentReference? = nil
        ref = db.collection("books").addDocument(data: [
            "title": title,
            "author": author,
            "date": date
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    func deleteBook(at offsets: IndexSet) {
        offsets.forEach({ index in
            let book = books[index]
            db.collection("books").document(book.id!).delete()            
        })
        books.remove(atOffsets: offsets)
    }

    
    func setListener(user: User?) {
        if let existingListener = listener {
            existingListener.remove()
            print("Existing listener removed")
            listener = .none
            books = []
        }
        
        if let user = user {
            let collection = Firestore.firestore().collection("books")
            listener = collection.addSnapshotListener { [weak self] (querySnapshot, error) in
                self?.snapshotListener(querySnapshot: querySnapshot, error: error)
            }
            print("Listener added for \(user.uid)")
        }
    }
}

