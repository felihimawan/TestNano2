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
                .font(.largeTitle)
                .padding()
            Text("\(completedStage) stages completed")
                .font(.title)
                .padding()
            Button(action: onClose) {
                Text("OK")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .frame(width: 300, height: 200)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}
