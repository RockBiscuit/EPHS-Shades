//
//  feef.swift
//  messagingApp
//
//  Created by 90308616 on 5/24/22.
//

import SwiftUI

struct feef: View {
  var body: some View {
      VStack {
        Spacer()
        Group {
          Text("Content")
          Text("Content")
          Text("Content")
          Text("Content")
          Text("Content")
          Text("Content")
          Text("Content")
          Text("Content")
          Text("Content")
          Text("Content")
        }
          HStack{
            Spacer()
            TextField("INPUT", text: .constant("HERE IS INPUT"))
            Spacer()
          }
      }
      
  }
}


struct feef_Previews: PreviewProvider {
    static var previews: some View {
        feef()
    }
}
