//
//  MenuMapper.swift
//  LunchMenuAssessment
//
//  Created by colden.prime on 10/30/24.
//

extension Menu {
  enum Mapper {
    static func from(response: MenuResponse) -> Menu {
      Menu(
        referenceDate: response.referenceDate,
        weeks: response.weeks
      )
    }
  }
}
