//
//  SpeakerView.swift
//  MeetingOptimiser
//
//  Created by Leong Zhe Cheng on 6/6/23.
//

import SwiftUI

struct SpeakerView: View {
    
    let speaker: EmployeeModel
    
    var body: some View {
        HStack {
            Text(speaker.name)
        }
    }
}

struct SpeakerView_Previews: PreviewProvider {
    static var previews: some View {
        SpeakerView(speaker: .example)
    }
}
