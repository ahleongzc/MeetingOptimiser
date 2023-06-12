//
//  MeetingHistoryView.swift
//  MeetingOptimiser
//
//  Created by Leong Zhe Cheng on 31/5/23.
//

import SwiftUI

struct MeetingHistoryView: View {
    
    @ObservedObject var meetingVM: MeetingViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(meetingVM.history) { meeting in
                        NavigationLink {
                            SingleMeetingDetailedView(meeting: meeting)
                        } label: {
                            SingleMeetingView(meeting: meeting)
                        }
                    }
                }
            }
            .navigationTitle(Text("Meeting History"))
        }
    }
}

struct MeetingHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingHistoryView(meetingVM: MeetingViewModel())
    }
}
