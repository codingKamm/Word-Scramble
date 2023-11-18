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
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    func addNewWord() {
        // lowercase and trim word to avoid duplications
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        // exit if remaining sting is empty
        guard answer.count > 0 else {return}
        
        guard isOrginal(word: answer) else {
            wordError(title: "word is already used", message: "try a different word")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "word not possible", message: "it is not possible to create from \(rootWord)")
            return
        }
        guard isReal(word: answer) else {
            wordError(title: "word is not real", message: "made up words are not acceptable")
            return
        }
        
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
    
    func isOrginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRanged = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRanged.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
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
            .alert(errorTitle, isPresented: $showingError) {
                Button("Ok") {}
            } message: {
                Text(errorMessage)
            }
            .toolbar{
                ToolbarItem(placement: .automatic) {
                    Button("start game") {
                        startGame()
                    }
                }
            }
            
        }// end of NavStack
    }
}

#Preview {
    ContentView()
}
