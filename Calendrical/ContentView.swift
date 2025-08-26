//
//  ContentView.swift
//  Calendrical
//
//  Created by Ahmed Juvale on 8/25/25.
//

import SwiftUI

struct ContentView: View {
    @State
    private var monthString = ""
    @State
    private var count = 0

    var body: some View {
        VStack {
            HStack(alignment: .top) {
                if let monthInt = Calendar.current.dateComponents([.month], from: Date()).month {
                    var monthStr = Calendar.current.monthSymbols[monthInt - 1]
                    Text(monthStr)
                        .font(.title)

                    Spacer()

                    Button {
                        // Back arrow takes to previous month
//                        count -= 1
//                        monthString = Calendar.current.monthSymbols[monthInt-count-1]
                    } label: {
                        Image(systemName: "chevron.backward")
                    }
                    .frame(alignment: .trailing)

                    Button {
                        // Forward arrow takes to next month
                    } label: {
                        Image(systemName: "chevron.forward")
                    }
                    .frame(alignment: .trailing)
                }
            }

//            GridRow {
//            }
        }
        .frame(width: 500, height: 1000)
        .padding()
    }

    private func getCurrentMonth(monthInt: Int) -> String {
        Calendar.current.monthSymbols[monthInt - 1]
    }

}

#Preview {
    ContentView()
}
