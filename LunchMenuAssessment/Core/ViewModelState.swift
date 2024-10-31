//
//  ViewModelState.swift
//  LunchMenuAssessment
//
//  Created by colden.prime on 10/30/24.
//

import Foundation

enum ViewModelState<T: Equatable> {
  case idle
  case loaded(T)
  case loading
  case error(Error)
}
