//
//  MenuViewProvider.swift
//  LunchMenuAssessment
//
//  Created by colden.prime on 10/30/24.
//

import SwiftUI

enum MenuViewProvider {
  public static func menuPage(
    apiService: MenuAPIService
  ) -> some View {
    MenuPageView(
      viewModel: MenuPageViewModel(
        dataSource: DefaultMenuDataSource(
          apiService: apiService
        ),
        nowProvider: Clock()
      )
    )
  }
}
