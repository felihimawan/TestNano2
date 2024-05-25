//
//  GameOverPopupView.swift
//  TestNano2
//
//  Created by Felicia Himawan on 19/05/24.
//

import SwiftUI

struct GameOverPopupView: View {
    var completedStage: Int
    var onClose: () -> Void
    
    var body: some View {
        VStack {
            Text("Game Over")
                .font(.system(size: 55, weight: .heavy))
                .foregroundColor(Color("text_color"))
                .padding()
            Text("\(completedStage)")
                .font(.system(size: 55, weight: .heavy))
                .foregroundColor(Color("text_color"))
            Text("Stages Completed")
                .font(.title)
                .fontWeight(.medium)
                .foregroundColor(Color("text_color"))
//            Button(action: onClose) {
//                Text("OK")
//                    .font(.title)
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
            Button(action: {
                onClose()
            }){
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color("button_game_bg"))
                    .frame(width: 130, height: 80)
                    .shadow(color: .gray, radius: 2, x: 0, y: 3)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15.0)
                            .fill(Color("button_bg_color"))
                            .frame(width: 100, height: 50)
                            .overlay(
                                Text("Ok")
                                    .font(.system(size: 35, weight: .bold))
                                    .foregroundColor(Color("text_color"))
                                    
                            )
                        
                        
                    )
            }
            .padding()
         
        }
        .frame(width: 400, height: 400)
        .background(Color("game_bg"))
        .cornerRadius(20)
        //.shadow(color: .gray, radius: 4, x: 0, y: 3)
    }
}


#Preview {
    GameOverPopupView(completedStage: 5, onClose: { print("Popup closed") })
}
