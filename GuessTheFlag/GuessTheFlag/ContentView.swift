//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Danny Capua on 5/7/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var showingFinalAlert = false
    @State private var scoreTitle = ""
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland","Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var userScore = 0
    @State private var gameCount = 0
    
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.3), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea() // goes above dynamic island
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                VStack (spacing: 15){
                    VStack{
                        Text("Tap the flag of")
                            .foregroundColor(.secondary) // Color.primary or secondary is a semantic color that changes based on the device theme
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .foregroundColor(.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3){number in //makes three flag buttons
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number]) // i.e. Image("Estonia"), etc. from assets folder
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial) // applies a frosted glass-style blur to the background
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(userScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
                
                Text("Game: \(gameCount)/8")
                    .foregroundColor(.white)
                    .font(.title.bold())
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore){ // showingShore is changed when any flag is tapped
            Button("Continue", action: askQuestion) // goes to next question
        } message: {
            Text("Your score is \(userScore)")
        }
        .alert("Final game. Resetting...", isPresented: $showingFinalAlert){
            Button("Start Next Game", action: reset)
        }
        
    }
    
    func flagTapped(_ number: Int){
        if number == correctAnswer{
            scoreTitle = "Correct"
            userScore+=1
        } else {
            scoreTitle = "Wrong, that's the flag of \(countries[number])"
        }
        
        showingScore = true
        gameCount+=1
        
        if gameCount == 8 {
            showingFinalAlert = true
        }
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func reset(){
        userScore = 0
        gameCount = 0
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
