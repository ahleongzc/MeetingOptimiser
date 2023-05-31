//
//  DuplicateEntryMessageView.swift
//  MeetingOptimiser
//
//  Created by Leong Zhe Cheng on 31/5/23.
//

import SwiftUI

struct DuplicateEntryMessageView: View {
    
    let message: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 200, height: 100)
                .cornerRadius(20)
                .foregroundColor(.white)
                .shadow(radius: 10)
            
            Text(message)
        }
    }
}

struct DuplicateEntryMessageView_Previews: PreviewProvider {
    static var previews: some View {
        DuplicateEntryMessageView(message: "Duplicated entry")
    }
}
