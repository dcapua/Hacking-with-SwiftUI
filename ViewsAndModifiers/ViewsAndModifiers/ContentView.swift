//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Danny Capua on 5/29/23.
//

import SwiftUI

struct BlueFontView: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.largeTitle).foregroundColor(.blue)
    }
}

extension View {
    func makeProminentTitle() -> some View {
        modifier(BlueFontView())
    }
}

struct Watermark: ViewModifier { // custom view modifier
    var text: String
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing){
            content
            
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(.blue)
        }
    }
    
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

struct ContentView: View {
    
    var body: some View {
        VStack{
            Color.blue
                .frame(width: 300, height:200)
                .watermarked(with: "test1") // puts the color blue in a ZStack with caption text
            Text("test2").makeProminentTitle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
