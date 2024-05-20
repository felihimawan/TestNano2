//
//  HighScoreModel.swift
//  TestNano2
//
//  Created by Felicia Himawan on 20/05/24.
//

import Foundation
import SwiftData

@Model
class HighScoreModel : Identifiable{
    var id = UUID()
    var highscore: Int
    
    init(id: UUID = UUID() , highscore: Int){
        self.id = id
        self.highscore = highscore
    }
    
}
