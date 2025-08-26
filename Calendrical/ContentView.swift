//
//  ContentView.swift
//  Calendrical
//
//  Created by Ahmed Juvale on 8/25/25.
//

import SwiftUI

struct ContentView: View {
    @State
    private var monthIndex: Int = Calendar.current.component(.month, from: Date()) - 1

    @State
    private var count = 0

    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(Calendar.current.monthSymbols[monthIndex])
                                    .font(.title)

                Spacer()

                Button {
                    // Back arrow takes to previous month
                    monthIndex = (monthIndex - 1 + 12) % 12
                } label: {
                    Image(systemName: "chevron.backward")
                }
                .frame(alignment: .trailing)

                Button {
                    // Forward arrow takes to next month
                    monthIndex = (monthIndex + 1) % 12
                } label: {
                    Image(systemName: "chevron.forward")
                }
                .frame(alignment: .trailing)
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
