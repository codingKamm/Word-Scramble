//
//  ContentView.swift
//  Word Scramble
//
//  Created by Cameron Warner on 11/17/23.
//

import SwiftUI

struct ContentView: View {
    
    let people = ["Kam", "Krissie", "Chris", "Cam", "Cheetah"]
    
    var body: some View {
        VStack{
            List(people, id: \.self) {
                Text("im in the club f*cked up, I got \($0) with me. - Webbie")
            }
            
           
            
         
            
        }// end of VStack
        
    }
}

#Preview {
    ContentView()
}
