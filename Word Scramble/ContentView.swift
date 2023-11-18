//
//  ContentView.swift
//  Word Scramble
//
//  Created by Cameron Warner on 11/17/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    func addNewWord() {
        // lowercase and trim word to avoid duplications
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        // exit if remaining sting is empty
        guard answer.count > 0 else {return}
        
        // xtra validation to come
        withAnimation{
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
    }
    
    func startGame() {
        // finds url in app bundle
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // load into string
            if let startWords = try? String(contentsOf: startWordsURL){
                // splits words into an array of string, spliiting on a new line
                let allWords = startWords.components(separatedBy: "\n")
                
                rootWord = allWords.randomElement() ?? "silkworms"
                
                return
            }
        }
        // if code reaches here, there is an error
        fatalError("could not load start.txt from bundle")
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                List{
                    Section{
                        TextField("Enter Your Word", text: $rootWord)
                            .textInputAutocapitalization(.never)
                    }
                }
                
                Section{
                    ForEach(usedWords, id: \.self){ word in 
                        HStack{
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                        
                    }
                }
                
                
                
                
                
            }// end of VStack
            .navigationTitle("Root Word")
            .onSubmit(addNewWord)
            .onAppear(perform:startGame)
        }// end of NavStack
    }
}

#Preview {
    ContentView()
}
