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
            Rectangle()
                .fill(button.color)
                .frame(width: 90, height: 90)
                .overlay(Text("\(button.id)").foregroundColor(.white))
        }
        .disabled(!viewModel.isPlaying || viewModel.isShowingPattern)
    }
}
