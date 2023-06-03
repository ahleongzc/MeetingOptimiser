//
//  DigitalClockView.swift
//  MeetingOptimiser
//
//  Created by Leong Zhe Cheng on 1/6/23.
//

import SwiftUI


struct DigitalClockView: View {
    
    let clockTimer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    let calendar = Calendar.current
    
    @State var currentDate = Date()
    @State var hour : NSInteger = 0
    @State var minute : NSInteger = 0
    @State var second : NSInteger = 0
    
    var body: some View {
        ZStack {
            HStack {
                Text("\(currentDate, format: .dateTime.year().month().day())  \(hour):\(minute, specifier: "%.2d"):\(second, specifier: "%.2d")")
            }
            .font(.title2)
            .bold()
        }
        .onReceive(clockTimer) {
            time in
            currentDate = time
            hour = calendar.component(.hour, from: currentDate)
            minute = calendar.component(.minute, from: currentDate)
            second = calendar.component(.second, from: currentDate)
        }
    }
}

struct DigitalClockView_Previews: PreviewProvider {
    static var previews: some View {
        DigitalClockView()
    }
}
