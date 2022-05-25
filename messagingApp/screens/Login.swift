//
//  Login.swift
//  messagingApp
//
//  Created by 90308616 on 5/17/22.
//

import SwiftUI

struct Login: View {
    @State var email = ""
    @State var password = ""
    @ObservedObject var sessionSession = SessionStore()
    var body: some View {
        NavigationView{
            VStack{
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    sessionSession.signIn(email: email, password: password)
                }, label: {
                    Text("Login")
                     
                    })
                Button(action: {
                    sessionSession.signUp(email: email, password: password)
                    
                }, label: {
                    Text("Sign Up")
                    
                    })
                }
            .navigationBarTitle("Shades")
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
