//
//  PracticeView.swift
//  Word Scramble
//
//  Created by Cameron Warner on 11/17/23.
//

import SwiftUI

struct PracticeView: View {
    var body: some View {
        VStack{
            List{
                Section("Section 1"){
                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    Text("Hello, World!")
                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                }
            }
            
            List{
                Section("Section 2"){
                    ForEach(0..<5){
                        Text("Dynamic row \($0)")
                    }
                }
            }
            
            List{
                Section("Section 3"){
                    Text("Static row 1")
                    Text("Static row 2")
                    
                    ForEach(0..<7){
                        Text("Dynamic row \($0)")
                    }
                    
                    Text("Static row 3")
                    Text("Static row 4")
                }
            }
            .listStyle(.grouped)
            
            List(0..<7) {
                    Text("Dynamic list parameter \($0)")
                }
            
            
            
            
        }// End of VStack
    }
}

#Preview {
    PracticeView()
}
