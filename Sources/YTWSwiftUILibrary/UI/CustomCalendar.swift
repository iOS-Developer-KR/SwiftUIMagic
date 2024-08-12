//
//  SwiftUIView.swift
//  
//
//  Created by Taewon Yoon on 8/11/24.
//

import SwiftUI

enum CalendarTab: String, CaseIterable, Identifiable {
    case month = "Month"
    case week = "Week"
    case day = "Day"
    
    var id: String { self.rawValue }
}

@available(iOS 17.0, *)
struct CustomCalendarView: View {
//    @State private var selectedTab: CalendarTab = .month
    @State private var currentMonth: Date = Date()
    @State private var notes: [Date: String] = [:]
    @State private var selectedDate: Date = Date()

    var body: some View {
        MonthView(currentMonth: $currentMonth, selectedDate: $selectedDate)
    }
}

// Date formatter to format date strings
private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    return formatter
}()

@available(iOS 17.0, *)
struct MonthView: View {
    @Binding var currentMonth: Date
    @Binding var selectedDate: Date

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    currentMonth = Calendar.current.date(byAdding: .month, value: -1, to: currentMonth)!
                }) {
                    Image(systemName: "chevron.left")
                        .padding()
                }

                Spacer()

                Text(currentMonth, formatter: monthFormatter)
                    .font(.title2)
                    .padding()

                Spacer()

                Button(action: {
                    currentMonth = Calendar.current.date(byAdding: .month, value: 1, to: currentMonth)!
                }) {
                    Image(systemName: "chevron.right")
                        .padding()
                }
            }

            // Calendar grid for the current month
            CalendarGridView(selectedDate: $selectedDate, currentMonth: $currentMonth, calendar: .current)
        }
        .padding()
    }
}

@available(iOS 17.0, *)
struct CalendarGridView: View {
    @Binding var selectedDate: Date
    @Binding var currentMonth: Date
    let calendar: Calendar
    var isWeekView: Bool = false

    var body: some View {
        // Get the start and end dates for the calendar view
        let dateRange = monthDateRange()
        let dates = generateDates(for: dateRange, calendar: calendar)

        // Display the dates in a grid
        LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
            ForEach(dates, id: \.self) { date in
                ZStack {
                    if calendar.isDate(date, equalTo: selectedDate, toGranularity: .day) {
                        Circle()
                            .foregroundStyle(Color.blue.opacity(0.2))
                    }
                    Text("\(calendar.component(.day, from: date))")
                        .padding(.vertical)
                        .onTapGesture {
                            selectedDate = date
                            print(date)
                        }
                    
                }
            }
        }
    }
    
    // Generate an array of dates for the given date range
    private func generateDates(for dateRange: Range<Date>, calendar: Calendar) -> [Date] {
        var dates: [Date] = []
        var currentDate = dateRange.lowerBound
        while currentDate < dateRange.upperBound {
            dates.append(currentDate)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
        return dates
    }

    // Get the date range for the current week
    private func weekDateRange() -> Range<Date> {
        let weekInterval = calendar.dateInterval(of: .weekOfYear, for: selectedDate)!
        return weekInterval.start..<calendar.date(byAdding: .day, value: 7, to: weekInterval.start)!
    }

    // Get the date range for the current month
    private func monthDateRange() -> Range<Date> {
        let monthInterval = calendar.dateInterval(of: .month, for: currentMonth)!
        return monthInterval.start..<calendar.date(byAdding: .month, value: 1, to: monthInterval.start)!
    }
}

// Korea DateFormatter
private let monthFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYY년 M월"
    formatter.locale = .autoupdatingCurrent
    return formatter
}()

@available(iOS 17.0, *)
#Preview {
    CustomCalendarView()
}

