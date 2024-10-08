import SwiftUI

struct ContentView: View {
    private let options = ["🗿", "🧻", "✂️"]
    private let objectives = ["WIN", "LOSE"]
    private let maxRounds = 10
    
    @State private var gamePlay = Int.random(in: 0...2)
    @State private var gameObjective = Int.random(in: 0...1)
    @State private var rounds = 0
    @State private var score = 0
    @State private var scoreTitle = ""
    @State private var showingScore = false
    @State private var showingFinalAlert = false
    
    var correctAnswer: Int {
        (gameObjective == 0) ? (gamePlay + 1) % 3 : (gamePlay + 2) % 3
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.purple, Color.pink]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("Rock, Paper, Scissors, Shoot!")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(10)
                
                VStack(spacing: 15) {
                    gameInfoView
                    optionsView
                    scoreView
                }
                .padding()
                .background(Color.white.opacity(0.8))
                .cornerRadius(20)
                .shadow(radius: 10)
                
                Text("Round: \(rounds)/\(maxRounds)")
                    .font(.headline)
                    .foregroundColor(.white)
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert("Game Over", isPresented: $showingFinalAlert) {
            Button("Restart", action: resetGame)
        } message: {
            Text("Your final score is \(score)")
        }
    }
    
    var gameInfoView: some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 5) {
                Text("My Move")
                    .font(.headline)
                    .foregroundColor(.blue)
                Text(options[gamePlay])
                    .font(.system(size: 50))
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Your Objective")
                    .font(.headline)
                    .foregroundColor(.blue)
                Text(objectives[gameObjective])
                    .font(.title)
                    .foregroundColor(.green)
                    .fontWeight(.bold)
            }
        }
    }
    
    var optionsView: some View {
        HStack {
            ForEach(0..<3) { number in
                Button(action: { shoot(number) }) {
                    Text(options[number])
                        .font(.system(size: 50))
                        .frame(width: 80, height: 80)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(40)
                }
            }
        }
    }
    
    var scoreView: some View {
        Text("Score: \(score)")
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(.purple)
    }
    
    func shoot(_ number: Int) {
        rounds += 1
        if number == correctAnswer {
            score += 1
            scoreTitle = "Correct!"
        } else {
            score -= 1
            scoreTitle = "Wrong!"
        }
        
        if rounds >= maxRounds {
            showingFinalAlert = true
        } else {
            showingScore = true
        }
    }
    
    func askQuestion() {
        gamePlay = Int.random(in: 0...2)
        gameObjective = Int.random(in: 0...1)
    }
    
    func resetGame() {
        score = 0
        rounds = 0
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
