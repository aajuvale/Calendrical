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
    private var currentDate = Date()

    @State
    private var year = Calendar.current.component(.year, from: Date())

    var body: some View {
        let days = generateMonthDays(for: monthIndex)

        VStack {
            HStack(alignment: .top) {
                HStack {
                    Text("\(Calendar.current.monthSymbols[monthIndex])")
                        .font(.title)
                        .foregroundStyle(.blue)

                    Text(String(year))
                        .font(.title)
                }

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

            let daysOfWeek = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]

            HStack {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding()

            Grid {
                ForEach(0..<days.count/7, id: \.self) { week in
                    GridRow {
                        ForEach(0..<7, id: \.self) { dayIndex in
                            let value = days[week * 7 + dayIndex]
                            Text(value == 0 ? "" : "\(value)")
                                .frame(maxWidth: .infinity, minHeight: 30)
                                .background(
                                    (value == Calendar.current.component(.day, from: currentDate) &&
                                         monthIndex == Calendar.current.component(.month, from: Date()) - 1)
                                        ? Color.blue.opacity(0.2)
                                        : Color.clear
                                ) // highlight today
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                        }
                    }
                }
            }
        }
        .frame(width: 500, height: 1000)
        .padding()
    }

    /// Generate an array of Ints for each day in a month
    private func generateMonthDays(for monthIndex: Int) -> [Int] {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: Date())
        let components = DateComponents(year: year, month: monthIndex + 1, day: 1)

        guard let firstDay = calendar.date(from: components),
              let monthRange = calendar.range(of: .day, in: .month, for: firstDay) else {
            return []
        }

        let firstWeekday = calendar.component(.weekday, from: firstDay)

        var days: [Int] = Array(repeating: 0, count: firstWeekday - 1)

        days += monthRange.map { $0 }

        while days.count % 7 != 0 {
            days.append(0)
        }

        return days
    }


}

#Preview {
    ContentView()
}
