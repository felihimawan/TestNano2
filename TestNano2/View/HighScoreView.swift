//
//  HighScoreView.swift
//  TestNano2
//
//  Created by Felicia Himawan on 20/05/24.
//

import SwiftUI
import SwiftData

struct HighScoreView: View {
    //@Query var scores: [HighScoreModel]
    @Query(sort: [SortDescriptor(\HighScoreModel.highscore, order: .reverse)]) var scores: [HighScoreModel]
    
    var body: some View {
        Text("High Scores")
            .font(.largeTitle)
            .padding()
        List(scores.prefix(5)) { score in
            Text("score: \(score.highscore)")
        }
    }
}

#Preview {
    HighScoreView()
}
