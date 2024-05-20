//
//  ContentViewModel.swift
//  TestNano2
//
//  Created by Felicia Himawan on 17/05/24.
//

import Foundation
import SwiftUI
import AudioToolbox
import SwiftData

class ContentViewModel: ObservableObject {
    @Published var pressedButtonId: Int?
    @Published var isPlaying = false
    @Published var currentStage = 1
    @Published var pattern: [Int] = []
    @Published var playerInput: [Int] = []
    @Published var showGameOverPopup = false
    @Published var isShowingPattern = false
    
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
        isShowingPattern = true
        var delay = 0.0
        for id in pattern {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                self.highlightButton(id: id)
            }
            delay += 0.2
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                self.resetButton(id: id)
            }
            delay += 0.3
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.isShowingPattern = false
        }
    }
    
    
    func highlightButton(id: Int) {
        print("Highlighting button \(id)")
        if let index = buttons.firstIndex(where: { $0.id == id }) {
            buttons[index].color = .red
            self.playDTMFTone(for: id)
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
    
    
    func buttonPressed(id: Int) {
        if !isPlaying { return }
        
        print("Button \(id) pressed")
        playerInput.append(id)
        highlightButton(id: id)
        self.playDTMFTone(for: id)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.resetButton(id: id)
            self.checkPlayerInput()
        }
    }
    
    
    func playDTMFTone(for digit: Int) {
        guard digit >= 0 && digit <= 9 else { return }
        let dtmfTones: [SystemSoundID] = [
            1201, // DTMF tone for 1
            1202, // DTMF tone for 2
            1203, // DTMF tone for 3
            1204, // DTMF tone for 4
            1205, // DTMF tone for 5
            1206, // DTMF tone for 6
            1207, // DTMF tone for 7
            1208, // DTMF tone for 8
            1209, // DTMF tone for 9
            1200 // DTMF tone for 0
        ]
        
        let toneID = dtmfTones[digit]
        AudioServicesPlaySystemSound(toneID)
    }
    
    
    func checkPlayerInput() {
        //yang lama
        
        //                if playerInput.count == pattern.count {
        //                    if playerInput == pattern {
        //                        // Correct pattern
        //                        print("Correct pattern entered")
        //                        currentStage += 1
        //                        pattern = generatePattern(for: currentStage)
        //                        playerInput = []
        //                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        //                            self.showPattern()
        //                        }
        //                    } else {
        //                        // Incorrect pattern
        //                        print("Incorrect pattern entered, game over")
        //                        isPlaying = false
        //                        playerInput = []
        //                        resetAllButtons()
        //                        showGameOverPopup = true
        //                    }
        //                }
        
        // logic baru
        if playerInput.count == pattern.count {
            if playerInput == pattern {
                nextLevel()
            } else {
                gameOver()
            }
        }
        else{
            if(playerInput.count > 0){
                for i in 0...playerInput.count-1{
                    if(playerInput[i] != pattern[i]){
                        gameOver()
                    }
                }
            }
        }
        
    }
    
    func nextLevel(){
        // Correct pattern
        print("Correct pattern entered")
        currentStage += 1
        pattern = generatePattern(for: currentStage)
        playerInput = []
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.showPattern()
        }
    }
    
    func gameOver(){
        // Incorrect pattern
        print("Incorrect pattern entered, game over")
        isPlaying = false
        playerInput = []
        resetAllButtons()
        
        showGameOverPopup = true
    }
    
    func saveHighScore(stagesCompleted: Int, context: ModelContext){
        let newHighScore = HighScoreModel(highscore: stagesCompleted)
        context.insert(newHighScore)
    }
    
}
