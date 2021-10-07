//
//  Task.swift
//  PeriodCalendarApp
//
//  Created by Виктория Виноградова on 07.10.2021.
//

import SwiftUI

//Array of tasks...
struct Task: Identifiable {
    var id = UUID().uuidString
    var title: String
    var time: Date = Date()
}

struct TaskMetaData: Identifiable {
    var id = UUID().uuidString
    var task: [Task]
    var taskDate: Date
}

//sample date for testing...
func getSampleDate(offset: Int) -> Date {
    let calendar = Calendar.current
    
    let date = calendar.date(byAdding: .day, value: offset, to: Date())
    
    return date ?? Date()
}

//sample tasks...
var tasks: [TaskMetaData] = [
    TaskMetaData(task: [
        Task(title: "Talk to Justine"),
        Task(title: "iPhone 13 Great Design Change"),
        Task(title: "Nothing Much Workout "),
    ], taskDate: getSampleDate(offset: -2)),
    TaskMetaData(task: [
        Task(title: "Talk to Jane Erik"),
    ], taskDate: getSampleDate(offset: -3)),
    TaskMetaData(task: [
        Task(title: "Meeting with Alex"),
    ], taskDate: getSampleDate(offset: -4)),
    TaskMetaData(task: [
        Task(title: "Meeting with Alex"),
    ], taskDate: getSampleDate(offset: -1)),
]

