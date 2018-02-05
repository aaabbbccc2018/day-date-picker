//
//  DayDatePicker.Date.swift
//  DayDatePicker
//
//  Created by Hugh Bellamy on 05/02/2018.
//

extension DayDatePickerView {
    public struct Date: Comparable {
        public static func <(lhs: DayDatePickerView.Date, rhs: DayDatePickerView.Date) -> Bool {
            if lhs.year < rhs.year {
                return true
            } else if lhs.year == rhs.year {
                if lhs.month < rhs.month {
                    return true
                } else if lhs.month == rhs.month && lhs.day < rhs.day {
                    return true
                }
            }

            return false
        }

        public static func ==(lhs: DayDatePickerView.Date, rhs: DayDatePickerView.Date) -> Bool {
            return lhs.year == rhs.year && lhs.month == rhs.month && lhs.day == rhs.day
        }

        public var date: Foundation.Date {
            get {
                var components = DateComponents()
                components.year = year
                components.month = month
                components.day = day

                return Calendar.current.date(from: components)!
            }
        }

        public var year: Int {
            willSet {
                if let yearsInEra = Calendar.current.range(of: .year, in: .era, for: date) {
                    precondition(newValue >= yearsInEra.lowerBound && newValue < yearsInEra.upperBound)
                }
            }
        }

        public var month: Int {
            willSet {
                if let monthsInYear = Calendar.current.range(of: .month, in: .year, for: date) {
                    precondition(newValue >= monthsInYear.lowerBound && newValue < monthsInYear.upperBound)
                }
            }
        }

        public var day: Int {
            willSet {
                if let daysInMonth = Calendar.current.range(of: .day, in: .month, for: date) {
                    precondition(newValue >= daysInMonth.lowerBound && newValue < daysInMonth.upperBound)
                }
            }
        }
    }
}
