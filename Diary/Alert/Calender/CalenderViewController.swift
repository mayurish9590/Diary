//
//  CalenderViewController.swift
//  Dairy
//
//  Created by Mayuri Shekhar on 10/11/20.
//  Copyright © 2020 Mayuri Shekhar. All rights reserved.
//

import UIKit
import HorizonCalendar

class CalenderViewController: UIViewController {
    var calendarView: CalendarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.calendarView = CalendarView(initialContent: makeContent())
        
        view.addSubview(calendarView)

        calendarView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
          calendarView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
          calendarView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
          calendarView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
          calendarView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
        ])
        
    }
   
  
    
    private func makeContent() -> CalendarViewContent {
      let calendar = Calendar(identifier: .gregorian)

      let startDate = calendar.date(from: DateComponents(year: 2020, month: 01, day: 01))!
      let endDate = calendar.date(from: DateComponents(year: 2021, month: 12, day: 31))!

      return CalendarViewContent(
        calendar: calendar,
        visibleDateRange: startDate...endDate,
        monthsLayout: .vertical(options: .init(pinDaysOfWeekToTop: true, alwaysShowCompleteBoundaryMonths: true)))
    }
    
}
