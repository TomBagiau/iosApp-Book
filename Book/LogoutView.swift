//
//  LogoutView.swift
//  Book
//
//  Created by Tom on 10/02/2022.
//

import SwiftUI

struct LogoutView: View {
    @EnvironmentObject var model: ViewModel
    @State private var isOn = false
    
    var body: some View {
        VStack{
            HStack {
                if isOn{
                    Text("set light mode")
                } else {
                    Text("set dark mode")
                }
                Toggle(isOn: $isOn, label: {
                    Text("Label")
                })
                    .padding()
                    .labelsHidden()
            }
            if let user = model.user{
                Text("Hello, \(user.email ?? "email")")
                    .padding()
            }
            Button("Log out", action: {
                model.logout()
            })
        }.preferredColorScheme(isOn ? .dark : .light)
        .padding()
    }
}

struct LogoutView_Previews: PreviewProvider {
    static var previews: some View {
        LogoutView()
    }
}

    
