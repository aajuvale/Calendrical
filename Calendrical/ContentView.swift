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
        let days = generateMonthDays(for: monthIndex, year: Int(year))

        VStack {
            HStack(alignment: .top) {
                HStack {
                    Text("\(Calendar.current.monthSymbols[monthIndex])")
                        .font(.title)
                        .bold()
                        .foregroundStyle(.blue)

                    Text(String(year))
                        .font(.title)
                }

                Spacer()

                Button {
                    // Back arrow takes to previous month
                    monthIndex -= 1
                    if monthIndex > 11 {
                        monthIndex = 0
                        year -= 1
                    }
                } label: {
                    Image(systemName: "chevron.backward")
                }
                .frame(alignment: .trailing)

                Button {
                    // Forward arrow takes to next month
                    monthIndex += 1
                    if monthIndex > 11 {
                        monthIndex = 0
                        year += 1
                    }
                } label: {
                    Image(systemName: "chevron.forward")
                }
                .frame(alignment: .trailing)
            }
            .padding()

            let daysOfWeek = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]

            Grid {
                GridRow {
                    ForEach(daysOfWeek, id: \.self) { day in
                        Text(day)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity)
                    }
                }

                ForEach(0..<days.count/7, id: \.self) { week in
                    GridRow {
                        ForEach(0..<7, id: \.self) { dayIndex in
                            let value = days[week * 7 + dayIndex]
                            let isSelected = (value == Calendar.current.component(.day, from: currentDate) &&
                                              monthIndex == Calendar.current.component(.month, from: Date()) - 1)
                            Text(value == 0 ? "" : "\(value)")
                                .frame(maxWidth: .infinity, minHeight: 40)
                                .background(
                                    isSelected
                                        ? Color.blue.opacity(0.2)
                                        : Color.clear
                                )
                                .clipShape(.circle)
                        }
                    }
                }
            }
        }
        .frame(width: 500, height: 1000)
        .padding()
    }

    /// Generate an array of Ints for each day in a month
    private func generateMonthDays(for monthIndex: Int, year: Int) -> [Int] {
        let calendar = Calendar.current
        let year = year
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
