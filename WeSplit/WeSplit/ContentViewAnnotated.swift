//
//  ContentViewAnnotated.swift (Project 1 Part 1 Notes)
//  WeSplit
//
//  Created by Danny Capua on 4/30/23.
//

import SwiftUI

struct ContentViewAnnotated: View { // conforms to View protocol which requires it has a body property that returns some view
    @State private var name = "" //@State is a property wrapper that allows us to work around the immutability of structs. It tells SwiftUI to store the value somewhere that can be changed freely, outside of the struct.
    // when this value changes, SwiftUI reinvokes the body property
    let students = ["Harry", "Hermione", "Ron"]
    @State private var selectedStudent = "Harry"
    
//    var body: some View {
//        Form {
//            TextField ("Enter your name", text: $name) // $ makes a two-way binding - value of property is read, but also written back when changed
//            Text("Your name is \(name)")
//        }
//    }
    var body: some View { // "some view" is an opaque return type
        NavigationView { // nesting views like this is enabled by @ViewBuilder, a result builder
            //
            Form {
                Picker("Select your student",selection: $selectedStudent){
                    ForEach(students,id: \.self){
                        Text($0)
                    }
                }
            }
        }
    }
}

// shows canvas
struct ContentViewAnnotated_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewAnnotated()
    }
}
