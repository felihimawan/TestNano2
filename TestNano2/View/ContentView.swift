//
//  ContentView.swift
//  TestNano2
//
//  Created by Felicia Himawan on 15/05/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var context
    @StateObject var viewModel = ContentViewModel()
    @State private var showingHighScoreView = false
    
    var body: some View {
        VStack {
            
            HStack{
                if !viewModel.isPlaying {
                    Button("Play") {
                        viewModel.startGame()
                    }
                    .padding()
                } else {
                    Text("Stage: \(viewModel.currentStage)")
                        .padding()
                    
                }
                
                Button(action: {
                    showingHighScoreView = true
                }) {
                    Image(systemName: "trophy.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding()
                }
                .sheet(isPresented: $showingHighScoreView) {
                    HighScoreView()
                }
                
            }
            
            
            
            //            Text("Button id pressed: \(viewModel.pressedButtonId ?? 0)")
            //                .padding()
            
            ZStack {
                VStack(spacing: 10) {
                    HStack(spacing: 10) {
                        ButtonView(button: viewModel.buttons[0], viewModel: viewModel)
                        ButtonView(button: viewModel.buttons[1], viewModel: viewModel)
                        ButtonView(button: viewModel.buttons[2], viewModel: viewModel)
                    }
                    HStack(spacing: 10) {
                        ButtonView(button: viewModel.buttons[3], viewModel: viewModel)
                        ButtonView(button: viewModel.buttons[4], viewModel: viewModel)
                        ButtonView(button: viewModel.buttons[5], viewModel: viewModel)
                    }
                    HStack(spacing: 10) {
                        ButtonView(button: viewModel.buttons[6], viewModel: viewModel)
                        ButtonView(button: viewModel.buttons[7], viewModel: viewModel)
                        ButtonView(button: viewModel.buttons[8], viewModel: viewModel)
                    }
                    HStack(spacing: 10) {
                        Spacer()
                        ButtonView(button: viewModel.buttons[9], viewModel: viewModel)
                        Spacer()
                    }
                }
                
                
                if viewModel.showGameOverPopup {
                    GameOverPopupView(completedStage: viewModel.currentStage - 1) {
                        viewModel.showGameOverPopup = false
                        viewModel.saveHighScore(stagesCompleted: viewModel.currentStage - 1, context: context)
                    }
                    .transition(.scale)
                }
                
                
            }
            
            
            
        }
    }
}

#Preview {
    ContentView()
}
