//
//  ContentView.swift
//  messagingApp
//
//  Created by 90308616 on 5/13/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var sessionStore = SessionStore()
    
    init(){
        sessionStore.listen()
    }
    
    var body: some View {
        ChatList()
            .fullScreenCover(isPresented: $sessionStore.isAnon, content: { Login()
            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
