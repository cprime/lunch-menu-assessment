//
//  ContentView.swift
//  LunchMenuAssessment
//
//  Created by CompanyX on 7/10/24.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationStack {
      MenuViewProvider.menuPage(
        apiService: MenuRestAPIService()
      )
    }
  }
}

#Preview {
  ContentView()
}
