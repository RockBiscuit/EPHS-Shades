//
//  Messages.swift
//  messagingApp
//
//  Created by 90308616 on 5/20/22.
//

import SwiftUI

struct Messages: View {
    
    let chatroom: Chatroom
    @ObservedObject var viewModel = messagesViewModel()
    @State var messageField = ""
    @State private var copyID: Text = Text("Copy ID")
    private let pasteboard = UIPasteboard.general
    
    init(chatroom: Chatroom){
        self.chatroom = chatroom
        viewModel.fetchData(docId: chatroom.id)
    }
    var body: some View {
        VStack{
            VStack {
                Text(chatroom.title).font(.largeTitle).foregroundColor(.purple)
                HStack {
                    Text("ID: " + String(chatroom.joinCode)).font(.subheadline)
                    Button {
                        pasteboard.string = String(chatroom.joinCode)
                        self.copyID = Text("Copied!").foregroundColor(.purple)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.copyID = Text("Copy ID").foregroundColor(.white)
                        }
                    } label: {
                        copyID
                            .foregroundColor(.white)
                    }
                    
                    
                }
            }
            
            VStack{
                
                ScrollView {
                    
                    ForEach(viewModel.messages) { message in
                        if(chatroom.userId != message.uID) {
                            HStack{
                                Text(message.content)
                                    .padding(8)
                                    .background(Color.gray)                                    .cornerRadius(8)
                                Spacer()
                            }
                            .padding(.leading, 10)
                        } else {
                            HStack{
                                Spacer()
                                Text(message.content)
                                    .padding(8)
                                    .background(Color.purple)
                                    .cornerRadius(8)
                            }
                            .padding(.trailing, 10)
                        }
                    }.onDelete(perform: self.deleteRow)
                    
                }
                HStack{
                    Spacer()
                    TextField("Enter message...", text: $messageField)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        if(messageField != ""){
                            viewModel.sendMessage(messageContent: messageField, docId: chatroom.id)
                            messageField = ""
                        }
                    }, label: {
                        Text("Send")
                            .foregroundColor(.purple)
                    })
                    Spacer()
                }
            }
        }
        
    }
    private func deleteRow(at indexSet: IndexSet) {
        self.viewModel.messages.remove(atOffsets: indexSet)
    }
}

struct Messages_Previews: PreviewProvider {
    static var previews: some View {
        Messages(chatroom: Chatroom(id: "10101", title: "Hello!", joinCode: 10, userId: "123"))
    }
}
