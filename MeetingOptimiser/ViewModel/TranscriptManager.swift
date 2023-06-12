//
//  TranscriptManager.swift
//  MeetingOptimiser
//
//  Created by Leong Zhe Cheng on 11/6/23.
//

import Foundation

class TranscriptManager: ObservableObject {
    
    @Published var transcripts: [TranscriptModel] = []
    
    func addTranscript(_ transcript: TranscriptModel) {
        transcripts.append(transcript)
    }
    
}
