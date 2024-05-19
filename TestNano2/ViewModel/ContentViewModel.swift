//
//  ContentViewModel.swift
//  TestNano2
//
//  Created by Felicia Himawan on 17/05/24.
//

import Foundation
import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var pressedButtonId: Int?
    @Published var isPlaying = false
    @Published var currentStage = 1
    @Published var pattern: [Int] = []
    @Published var playerInput: [Int] = []
    
    var buttons: [ButtonModel] = [
        ButtonModel(id: 1),
        ButtonModel(id: 2),
        ButtonModel(id: 3),
        ButtonModel(id: 4),
        ButtonModel(id: 5),
        ButtonModel(id: 6),
        ButtonModel(id: 7),
        ButtonModel(id: 8),
        ButtonModel(id: 9),
        ButtonModel(id: 0)
    ]
    
    
    //    func buttonPressed(id: Int) {
    //        pressedButtonId = id
    //        for i in 0..<buttons.count {
    //            buttons[i].color = (buttons[i].id == id) ? .red : .blue
    //        }
    //    }
    
    func startGame() {
        print("Game started")
        isPlaying = true
        currentStage = 1
        pattern = generatePattern(for: currentStage)
        playerInput = []
        showPattern()
    }
    
    
    func generatePattern(for stage: Int) -> [Int] {
        let newPattern = (0..<stage).map { _ in buttons.randomElement()!.id }
        print("Generated pattern for stage \(stage): \(newPattern)")
        return newPattern
    }
    
    
    func showPattern() {
        print("Showing pattern: \(pattern)")
        var delay = 0.0
        for id in pattern {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                self.highlightButton(id: id)
            }
            delay += 0.4
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                self.resetButton(id: id)
            }
            delay += 0.4
        }
        // Ensure buttons reset to blue after showing pattern
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.resetAllButtons()
            print("Pattern shown, buttons reset to blue")
        }
    }
    
    
    func highlightButton(id: Int) {
        print("Highlighting button \(id)")
        if let index = buttons.firstIndex(where: { $0.id == id }) {
            buttons[index].color = .red
            objectWillChange.send()
            print("Highlighting button \(id) to red")
        }
        print("Highlighting button done")
    }
    
    func resetButton(id: Int) {
        print("Resetting button \(id)")
        if let index = buttons.firstIndex(where: { $0.id == id }) {
            buttons[index].color = .blue
            objectWillChange.send()
            print("Resetting button \(id) to blue")
        }
        print("Resetting button done")
    }
    
    func resetAllButtons() {
        print("Resetting all buttons to blue")
        for index in buttons.indices {
            buttons[index].color = .blue
        }
        objectWillChange.send()
        print("Resetting all buttons done")
    }
    
    
    //    func buttonPressed(id: Int) {
    //        if !isPlaying { return }
    //
    //        print("Button \(id) pressed")
    //        playerInput.append(id)
    //        highlightButton(id: id)
    //        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
    //            self.resetButton(id: id)
    //        }
    //
    //        if playerInput.count == pattern.count {
    //            if playerInput == pattern {
    //                // Correct pattern
    //                print("Correct pattern entered")
    //                currentStage += 1
    //                pattern = generatePattern(for: currentStage)
    //                playerInput = []
    //                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
    //                    self.showPattern()
    //                }
    //            } else {
    //                // Incorrect pattern
    //                print("Incorrect pattern entered, game over")
    //                isPlaying = false
    //                playerInput = []
    //                resetAllButtons()
    //            }
    //        }
    //
    //
    //    }
    
    func buttonPressed(id: Int) {
        if !isPlaying { return }
        
        print("Button \(id) pressed")
        playerInput.append(id)
        highlightButton(id: id)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.resetButton(id: id)
            self.checkPlayerInput()
        }
    }
    
    
    func checkPlayerInput() {
        if playerInput.count == pattern.count {
            if playerInput == pattern {
                // Correct pattern
                print("Correct pattern entered")
                currentStage += 1
                pattern = generatePattern(for: currentStage)
                playerInput = []
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.showPattern()
                }
            } else {
                // Incorrect pattern
                print("Incorrect pattern entered, game over")
                isPlaying = false
                playerInput = []
                resetAllButtons()
            }
        }
    }
    
    
}
