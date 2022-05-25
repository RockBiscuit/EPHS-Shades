//
//  ChatList.swift
//  messagingApp
//
//  Created by 90308616 on 5/17/22.
//

import SwiftUI
import FirebaseAuth

struct ChatList: View {
    
    @ObservedObject var viewModel = ChatroomsViewModel()
    @ObservedObject var chatModel = messagesViewModel()
    @ObservedObject var sessionSession = SessionStore()
    @State var joinModal = false
    let authRef = Auth.auth()
    
    init(){
        viewModel.fetchData()
    }
    
    var body: some View {
        ZStack{
        
        
            NavigationView{
                List{
                    
                ForEach(viewModel.chatrooms) { chatroom in
                    NavigationLink(destination: Messages(chatroom: chatroom)){
                        HStack{
                            VStack{
                            Text(chatroom.title).font(.system(size: 25.0))
                            }
                            Spacer()
                        }
                    }
                    .navigationBarTitle("Chatrooms")
                    .navigationBarItems(leading: Button(action: {
                        if(sessionSession.signOut()){
                            do{
                                try authRef.signOut()
                            } catch{
                                print("Error!")
                            }
                        } else{
                            print("Hey")
                        }
                    }, label: {
                        Text("Sign Out")
                    }),
                        trailing:
                        Button(action: {
                            self.joinModal = true
                        }, label: {
                            Text("New Room")
                        })
                        .padding(.trailing)
                        )
                    .sheet(isPresented: $joinModal, content: {
                        Join(isOpen: $joinModal)
                    })
                    
                }.onDelete(perform: self.deleteRow)
                
            }
            if(viewModel.chatrooms.count == 0) {
                Join(isOpen: $joinModal)
            }
        }
        }
    }
    private func deleteRow(at indexSet: IndexSet) {
        self.viewModel.chatrooms.remove(atOffsets: indexSet)
        }

}

struct ChatList_Previews: PreviewProvider {
    static var previews: some View {
        ChatList()
    }
}
