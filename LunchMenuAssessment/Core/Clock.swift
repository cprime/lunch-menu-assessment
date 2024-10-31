//
//  NowProvider.swift
//  LunchMenuAssessment
//
//  Created by colden.prime on 10/30/24.
//

import Foundation

protocol NowProvider {
  var now: Date { get }
}

struct Clock: NowProvider {
  static var shared = Clock()

  var now: Date {
    return Date.now
  }
}
