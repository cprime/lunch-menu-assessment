//
//  MenuPageData.swift
//  LunchMenuAssessment
//
//  Created by colden.prime on 10/30/24.
//

import Foundation

struct MenuPageData: Equatable {
  let menu: LunchMenu
  let today: Date

  func highlightWeek(_ week: LunchMenuWeek) -> Bool {
    guard let endOfWeek = week.startOfWeek.addDays(7) else {
      return false
    }
    return week.startOfWeek <= today && today < endOfWeek
  }

  func highlightDay(_ day: LunchMenuDay) -> Bool {
    day.date == today
  }
}
