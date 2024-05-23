//
//  ButtonView.swift
//  TestNano2
//
//  Created by Felicia Himawan on 17/05/24.
//

import SwiftUI

struct ButtonView: View {
    var button: ButtonModel
    @ObservedObject var viewModel: ContentViewModel
    
    var body: some View {
        Button(action: {
            viewModel.buttonPressed(id: button.id)
        }) {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(button.color)
                .frame(width: 90, height: 90)
                .shadow(color: .gray, radius: 2, x: 0, y: 3)
            //.overlay(Text("\(button.id)").foregroundColor(.white))
                .overlay(
                    RoundedRectangle(cornerRadius: 15.0)
                        .fill(button.color_pressed)
                        .frame(width: 50, height: 50)
                )
                .scaleEffect(button.scale)
                //.animation(.easeInOut(duration: 0.1), value: button.scale)
        }
        .disabled(!viewModel.isPlaying || viewModel.isShowingPattern)
    }
}
