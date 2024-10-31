//
//  LunchMenu.swift
//  LunchMenuAssessment
//
//  Created by colden.prime on 10/30/24.
//

import Foundation

let DAYS_PER_WEEK = 7

struct LunchMenuGenerationError: Error {}

struct LunchMenu: Equatable {
  let template: Menu
  let startDate: Date
  let endDate: Date
  let weeks: [LunchMenuWeek]

  func extended(byNumberOfWeeks numberOfWeeks: Int) throws -> LunchMenu {
    let extended = try LunchMenu.generate(
      for: template,
      startDate: endDate,
      numberOfWeeks: numberOfWeeks
    )

    return LunchMenu(
      template: template,
      startDate: startDate,
      endDate: extended.endDate,
      weeks: weeks + extended.weeks
    )
  }

  static func generate(for menu: Menu, startDate: Date, numberOfWeeks: Int) throws -> LunchMenu {
    let referenceMonday = menu.referenceDate.startOfWeek()
    let startMonday = startDate.startOfWeek()
    let endMonday = startMonday?.addDays(numberOfWeeks * DAYS_PER_WEEK)

    guard
      let referenceMonday = referenceMonday,
      let startMonday = startMonday,
      let endMonday = endMonday,
      let diff = startMonday.daysBetween(referenceMonday)
    else {
      throw LunchMenuGenerationError()
    }

    var weeks = [LunchMenuWeek]()
    var weekOffset = (diff / DAYS_PER_WEEK) % menu.weeks.count
    var currentMonday = startMonday
    while currentMonday < endMonday {
      let weekTemplate = menu.weeks[weekOffset]

      var days = [LunchMenuDay]()
      for i in 0..<weekTemplate.count {
        guard let date = currentMonday.addDays(i) else {
          throw LunchMenuGenerationError()
        }
        days.append(
          LunchMenuDay(
            date: date,
            meal: weekTemplate[i]
          )
        )
      }
      weeks.append(
        LunchMenuWeek(
          startOfWeek: currentMonday,
          days: days
        )
      )

      guard let nextMonday = currentMonday.addDays(DAYS_PER_WEEK) else {
        throw LunchMenuGenerationError()
      }
      currentMonday = nextMonday
      weekOffset = (weekOffset + 1) % menu.weeks.count
    }

    return LunchMenu(
      template: menu,
      startDate: startMonday,
      endDate: endMonday,
      weeks: weeks
    )
  }
}
