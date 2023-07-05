//
//  SingleTranscriptView.swift
//  MeetingOptimiser
//
//  Created by Leong Zhe Cheng on 5/7/23.
//

import SwiftUI

struct SingleTranscriptView: View {
    
    let transcript: TranscriptModel
    
    var body: some View {
        VStack {
            HStack {
                Text("\(transcript.speaker.name) : ")
                    .fixedSize(horizontal: false, vertical: true)
                Text(transcript.transcript)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding()
            .border(.black)
        }
        .padding()
    }
    
}

struct SingleTranscriptView_Previews: PreviewProvider {
    static var previews: some View {
        SingleTranscriptView(transcript: .example)
    }
}
