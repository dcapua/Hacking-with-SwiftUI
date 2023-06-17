//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Danny Capua on 6/10/23.
//

import SwiftUI

struct ContentView: View {
    
    private var possibleMoves = ["🪨", "🧻", "✂️"]
    private var winMoves = ["🧻","✂️","🪨"]
    private var loseMoves = ["✂️","🪨","🧻"]
    @State private var appCurrentChoice = Int.random(in: 0..<3)
    @State private var shouldWin = Bool.random()
    
    @State private var showingScore = false
    @State private var showingFinalAlert = false
    @State private var playerScore = 0
    @State private var gameCount = 0
    @State private var scoreTitle = ""
    
    
    var body: some View {
        ZStack{
            Color.green
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Score: \(playerScore)")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                //--
                Text("Game: \(gameCount)/10").bold()
                //--
                Text(possibleMoves[appCurrentChoice]).font(.system(size:200)) //emoji
                //--
                (shouldWin ? Text("Intention: WIN!") : Text("Intention: LOSE!"))
                    .font(.subheadline).bold()
                Spacer()
                //--
                HStack{
                    ForEach(0..<3){number in
                        Button {
                            choiceTapped(number)
                        } label: {
                            Text(possibleMoves[number]).font(.system(size:100)) // emoji
                        }
                        
                    }
                }
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .alert("Final game. Resetting...", isPresented: $showingFinalAlert){
                Button("Start Next Game", action: reset)
            }
            .alert(scoreTitle, isPresented: $showingScore){
                Button("Continue", action: doMove)
            }
            
        }
        
       
    }
    
    func choiceTapped(_ number: Int){
        if (shouldWin && possibleMoves[number] == winMoves[appCurrentChoice]) || (!shouldWin && possibleMoves[number] == loseMoves[appCurrentChoice]){
            playerScore += 1
            scoreTitle = "Correct!"
        }
        else {
            scoreTitle = "Incorrect!"
        }
        
        showingScore = true
        gameCount += 1
        
        if gameCount == 10 {
            showingFinalAlert = true
        }
        
    }
    
    func doMove(){
        shouldWin.toggle()
        appCurrentChoice = Int.random(in: 0..<3)
    }
    
    func reset(){
        playerScore = 0
        gameCount = 0
        
        doMove()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
