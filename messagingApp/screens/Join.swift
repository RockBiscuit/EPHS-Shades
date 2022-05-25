//
//  Join.swift
//  messagingApp
//
//  Created by 90308616 on 5/20/22.
//

import SwiftUI

struct Join: View {
    
    @Binding var isOpen: Bool
    @State var joinCode = ""
    @State var newTitle = ""
    @State private var chatText: String = "Create"
    @State private var joinText: String = "Join"
    @ObservedObject var viewModel = ChatroomsViewModel()
    var body: some View {
        NavigationView{
            VStack{
                VStack{
                    Text("Join a chatroom")
                        .font(.title)
                    TextField("Enter your join code", text: $joinCode)
                    Button(action: {
                        if(joinCode == ""){
                            self.joinText = "Please enter a join code"
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                self.joinText = "Join"
                            }
                        } else {
                            viewModel.joinChatroom(code: joinCode) {
                                self.isOpen = false
                            }
                        }
                    }, label: {
                        Text(joinText)
                    })
                }
                .padding(.bottom)
                VStack{
                    Text("Create a chatroom")
                        .font(.title)
                    TextField("Enter a new title", text: $newTitle)
                    Button(action: {
                        if(newTitle == ""){
                            self.chatText = "Please enter a name"
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                self.chatText = "Create"
                            }
                        } else {
                            viewModel.createChatroom(title: newTitle) {
                                self.isOpen = false
                            }
                        }
                    }, label: {
                        Text(chatText)
                    })
                }
                .padding(.top)
                
            }
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .navigationBarTitle("Join or create")
        }
    }
}

struct Join_Previews: PreviewProvider {
    static var previews: some View {
        Join(isOpen: .constant(true))
    }
}
