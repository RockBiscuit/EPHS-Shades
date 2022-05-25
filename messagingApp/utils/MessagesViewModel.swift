//
//  MessagesViewModel.swift
//  messagingApp
//
//  Created by 90308616 on 5/20/22.
//

import Foundation
import Firebase
import FirebaseFirestore

struct Message: Codable, Identifiable {
    var id: String?
    var content: String
    var name: String
    var uID: String
}


class messagesViewModel: ObservableObject{
    @Published var messages = [Message]()
    private let db = Firestore.firestore()
    private let user = Auth.auth().currentUser
    
    func sendMessage(messageContent: String, docId: String){
        if (user != nil){
            db.collection("chatrooms").document(docId).collection("messages").addDocument(data: ["sentAt": Date(),
                                                                                                 "displayName": user!.email ?? "anonymous",
                                                                                                 "content": messageContent,
                                                                                                 "sender": user!.uid])
        }
    }
    
    func fetchData(docId: String){
        if (user != nil){
            db.collection("chatrooms").document(docId).collection("messages").order(by: "sentAt", descending: false).addSnapshotListener({(snapshot, error) in
                guard let documents = snapshot?.documents else{
                    print("No documents")
                    return
                }
                
                self.messages = documents.map { docSnapshot -> Message in
                    let data = docSnapshot.data()
                    let docId = docSnapshot.documentID
                    let uID = data["sender"] as? String ?? ""
                    let content = data["content"] as? String ?? ""
                    let displayName = data["displayName"] as? String ?? ""
                    return Message(id: docId, content: content, name: displayName, uID: uID)
                    
                }
                
                
            })
        }
        
    }
}
