//
//  MenuPageViewModel.swift
//  LunchMenuAssessment
//
//  Created by colden.prime on 10/30/24.
//

import Foundation

class MenuPageViewModel: ObservableObject {
  let dataSource: MenuDataSource
  let nowProvider: NowProvider

  @Published private(set) var state: ViewModelState<MenuPageData> = .idle

  init(dataSource: MenuDataSource, nowProvider: NowProvider) {
    self.dataSource = dataSource
    self.nowProvider = nowProvider
  }

  @MainActor func fetchMenu() async {
    state = .loading
    do {
      let menu = try await dataSource.fetchMenu()
      let now = nowProvider.now

      guard
        let today = now.startOfDay(),
        let start = nowProvider.now.startOfWeek(),
        let lunchMenu = try? LunchMenu.generate(for: menu, startDate: start, numberOfWeeks: 8)
      else {
        throw LunchMenuGenerationError()
      }

      state = .loaded(MenuPageData(menu: lunchMenu, today: today))
    } catch {
      state = .error(error)
    }
  }

  @MainActor func extendMenu() async {
    guard case .loaded(let pageData) = state else {
      return
    }
    guard let extendedMenu = try? pageData.menu.extended(byNumberOfWeeks: 8) else {
      return
    }
    state = .loaded(MenuPageData(menu: extendedMenu, today: pageData.today))
  }
}
