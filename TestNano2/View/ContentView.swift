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
        ZStack{
            Image("phone")
                .resizable()
                .scaledToFit()
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding()
            
            VStack{
                
                HStack{
                    Spacer()
                    
                    Button(action: {
                        showingHighScoreView = true
                    }) {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color("button_game_bg"))
                            .frame(width: 70, height: 70)
                            .shadow(color: .gray, radius: 2, x: 0, y: 3)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15.0)
                                    .fill(Color("button_bg_color"))
                                    .frame(width: 50, height: 50)
                                    .overlay(
                                        Image(systemName: "trophy.fill")
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                            .foregroundColor(Color("text_color"))
                                    )
                                
                                
                            )
                        
                        
                    }
                    .padding()
                    .sheet(isPresented: $showingHighScoreView) {
                        HighScoreView()
                    }
                }
                
              
                
                
                
                if !viewModel.isPlaying {
                    Button(action: {
                        viewModel.startGame()
                    }){
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color("button_game_bg"))
                            .frame(width: 300, height: 100)
                            .shadow(color: .gray, radius: 2, x: 0, y: 3)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15.0)
                                    .fill(Color("button_bg_color"))
                                    .frame(width: 260, height: 70)
                                    .overlay(
                                        Text("Play")
                                            .font(.system(size: 55, weight: .heavy))
                                            .foregroundColor(Color("text_color"))
                                            
                                    )
                                
                                
                            )
                    }
                 
                  
                } else {
                    Text("Stage: \(viewModel.currentStage)")
                        .font(.system(size: 55, weight: .heavy))
                        .foregroundColor(Color("text_color"))

                    
                }
                
                
                
                
                //            Text("Button id pressed: \(viewModel.pressedButtonId ?? 0)")
                //                .padding()
                
                ZStack {
                    VStack(spacing: 20) {
                        HStack(spacing: 30) {
                            ButtonView(button: viewModel.buttons[0], viewModel: viewModel)
                            ButtonView(button: viewModel.buttons[1], viewModel: viewModel)
                            ButtonView(button: viewModel.buttons[2], viewModel: viewModel)
                        }
                        HStack(spacing: 30) {
                            ButtonView(button: viewModel.buttons[3], viewModel: viewModel)
                            ButtonView(button: viewModel.buttons[4], viewModel: viewModel)
                            ButtonView(button: viewModel.buttons[5], viewModel: viewModel)
                        }
                        HStack(spacing: 30) {
                            ButtonView(button: viewModel.buttons[6], viewModel: viewModel)
                            ButtonView(button: viewModel.buttons[7], viewModel: viewModel)
                            ButtonView(button: viewModel.buttons[8], viewModel: viewModel)
                        }
                        HStack(spacing: 30) {
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
                .padding(.bottom, 120.0)
                .frame(maxHeight: .infinity, alignment: .bottom)
                
                
                
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .background(Color("game_bg"))
    }
}

#Preview {
    ContentView()
}
