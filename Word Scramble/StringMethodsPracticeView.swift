//
//  StringsPracticeView.swift
//  Word Scramble
//
//  Created by Cameron Warner on 11/17/23.
//

import SwiftUI

struct StringMethodsPracticeView: View {
    
    let input = "a b c"
    let input2 = """
                 a
                 b
                 c
                 """
 
    let word = "swift"
    let checker = UITextChecker()
 
    let people = ["Kam", "Krissie", "Chris", "Cam", "Cheetah"]
    
    var body: some View {
        VStack{
            List(people, id: \.self) {
                Text("im in the club f*cked up, I got \($0) with me. - Webbie")
            }
            
            let letters = input.components(separatedBy: " ")
            let letters2 = input2.components(separatedBy: "\n")
            
            let randomLetter = input.randomElement() //selects by random
            
            let trimmed = input.trimmingCharacters(in: .whitespacesAndNewlines)
            //which asks Swift to remove certain kinds of characters from the start and end of a string. This uses a new type called CharacterSet, but most of the time we want one particular behavior: removing whitespace and new lines – this refers to spaces, tabs, and line breaks, all at once.
            
            let range = NSRange(location: 0, length: word.utf16.count)
            //UTF-16 is what’s called a character encoding – a way of storing letters in a string. We use it here so that Objective-C can understand how Swift’s strings are stored;
            
            let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
            //That sends back another Objective-C string range, telling us where the misspelling was found.
            
            let allGood = misspelledRange.location == NSNotFound
        }
        
    }
}

#Preview {
    StringMethodsPracticeView()
}
