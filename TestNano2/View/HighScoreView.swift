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
        let uniqueScores = Array(Set(scores.map { $0.highscore })).sorted(by: >)
        
        ZStack {
            VStack{
                
                
                
                Text("High Scores")
                    .font(.system(size: 55, weight: .heavy))
                    .foregroundColor(Color("text_color"))
                    .padding(.bottom, 100.0)
                
                
                
                
                HStack(alignment: .bottom, spacing: 50){
                    VStack{
                        Text("\(uniqueScores[1]) stages")
                            .font(.system(size: 35, weight: .bold))
                            .foregroundColor(Color("text_color"))
                        Rectangle()
                            .fill(Color("button_game_bg"))
                            .frame(width: 120, height: 300)
                            .cornerRadius(25)
                            .overlay(
                                Text("2")
                                    .font(.system(size: 35, weight: .bold))
                                    .padding()
                                    .foregroundColor(Color.white)
                                    .frame(height: 300, alignment: .top)
                                
                            )
                        
                    }
                    
                    VStack{
                        Text("\(uniqueScores[0]) stages")
                            .font(.system(size: 35, weight: .bold))
                            .foregroundColor(Color("text_color"))
                        Rectangle()
                            .fill(Color("button_game_bg"))
                            .frame(width: 120, height: 400)
                            .cornerRadius(25)
                            .overlay(
                                Text("1")
                                    .font(.system(size: 35, weight: .bold))
                                    .padding()
                                    .foregroundColor(Color.white)
                                    .frame(height: 400, alignment: .top)
                                
                            )
                        
                    }
                    
                    VStack{
                        Text("\(uniqueScores[2]) stages")
                            .font(.system(size: 35, weight: .bold))
                            .foregroundColor(Color("text_color"))
                        Rectangle()
                            .fill(Color("button_game_bg"))
                            .frame(width: 120, height: 200)
                            .cornerRadius(25)
                            .overlay(
                                Text("3")
                                    .font(.system(size: 35, weight: .bold))
                                    .padding()
                                    .foregroundColor(Color.white)
                                    .frame(height: 200, alignment: .top)
                                
                            )
                        
                    }
                    
                }
                .padding(.top, 20.0)
                .overlay(alignment: .bottom){
                    Rectangle()
                        .fill(Color("accent_color"))
                        .frame(height: 40)
                        .cornerRadius(15)
                }
                    
                    
                    
                
                
                
//                Text("4. 3 stages")
//                    .font(.system(size: 35, weight: .bold))
//                    .foregroundColor(Color("text_color"))
//                    .padding()
//                
//                Text("5. ")
//                    .font(.system(size: 35, weight: .bold))
//                    .foregroundColor(Color("text_color"))
//                    .padding()
                
                
                
            }
            .padding()
//            .frame(maxHeight: .infinity, alignment: .top)

        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("game_bg"))
        
        
        //        List(scores.prefix(5)) { score in
        //            Text("score: \(score.highscore)")
        //        }
    }
    
}

//#Preview {
//    HighScoreView()
//}
