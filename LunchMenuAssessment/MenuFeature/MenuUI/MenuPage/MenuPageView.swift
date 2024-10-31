//
//  MenuView.swift
//  LunchMenuAssessment
//
//  Created by colden.prime on 10/30/24.
//

import SwiftUI

struct MenuPageView: View {
  @StateObject var viewModel: MenuPageViewModel

  var body: some View {
    contentView(for: viewModel.state)
      .navigationTitle("Lunch Menu")
      .task {
        await viewModel.fetchMenu()
      }
  }

  @ViewBuilder
  func contentView(for state: ViewModelState<MenuPageData>) -> some View {
    switch state {
    case .idle, .loading:
      ProgressView()
    case .error(_):
      VStack(spacing: 8) {
        Text("Loading Failed")
        Button {
          Task {
            await viewModel.fetchMenu()
          }
        } label: {
          HStack {
            Text("Try again")
            Image(systemName: "arrow.counterclockwise")
          }
        }
      }
    case .loaded(let pageData):
      MenuLoadedView(viewModel: viewModel, pageData: pageData)
    }
  }
}

struct MenuLoadedView: View {
  let viewModel: MenuPageViewModel
  let pageData: MenuPageData

  var body: some View {
    ScrollView {
      LazyVStack(alignment: .leading, spacing: 10) {
        ForEach(pageData.menu.weeks, id: \.self) { week in
          MenuWeekView(
            pageData: pageData,
            week: week
          )
        }
        HStack(alignment: .center) {
          Spacer()
          ProgressView()
          Spacer()
        }
        .task {
          await viewModel.extendMenu()
        }
      }
      .padding(
        EdgeInsets(
          top: 8,
          leading: 10,
          bottom: 50,
          trailing: 10
        )
      )
    }
  }
}

struct MenuWeekView: View {
  let pageData: MenuPageData
  let week: LunchMenuWeek

  var body: some View {
    let highlightWeek = pageData.highlightWeek(week)

    VStack(alignment: .leading, spacing: 4) {
      HStack(spacing: 4) {
        if highlightWeek {
          Text("THIS WEEK:")
        }
        Text(week.title)
      }
      .font(.footnote)
      .fontWeight(.bold)
      ForEach(week.days, id: \.self) { entry in
        MenuDayView(
          entry: entry,
          highlight: pageData.highlightDay(entry)
        )
      }
    }
    .padding(8)
    .background {
      if highlightWeek {
        RoundedRectangle(cornerRadius: 10)
          .fill(Color.gray.opacity(0.1))
      }
    }
    .overlay {
      if highlightWeek {
        RoundedRectangle(cornerRadius: 10)
          .stroke(
            Color.gray,
            lineWidth: 1
          )
      }
    }
  }
}

struct MenuDayView: View {
  let entry: LunchMenuDay
  let highlight: Bool

  init(entry: LunchMenuDay, highlight: Bool = false) {
    self.entry = entry
    self.highlight = highlight
  }

  var body: some View {
    HStack(alignment: .center) {
      VStack(alignment: .trailing) {
        Text(entry.dayOfWeek)
          .font(.footnote)
        Text(entry.dayOfMonth)
          .font(.headline)
      }
      .frame(minWidth: 40, alignment: .trailing)
      Divider()
        .background(highlight ? Color.blue : Color.gray)
      Text(entry.meal)
        .font(.title3)
      Spacer()
    }
    .padding()
    .overlay {
      RoundedRectangle(cornerRadius: 10)
        .stroke(
          highlight ? Color.blue : Color.gray,
          lineWidth: highlight ? 2 : 1
        )
    }
    .fontWeight(highlight ? .bold : .regular)
    .foregroundColor(highlight ? Color.blue : Color.black)
  }
}

#if DEBUG
#Preview {
  NavigationStack {
    MenuPageView(
      viewModel: MenuPageViewModel(
        dataSource: DefaultMenuDataSource(
          apiService: StubbedMenuAPIService()
        ),
        nowProvider: StubbedClock()
      )
    )
  }
}

struct StubbedMenuAPIService: MenuAPIService {
  func fetchMenu() async throws -> Menu {
    return Menu(
      referenceDate: Date.fromISO8601("2024-09-02T00:00:00Z")!,
      weeks: [
        ["Chicken and waffles", "Tacos", "Curry", "Pizza", "Sushi"],
        ["Breakfast for lunch", "Hamburgers", "Spaghetti", "Salmon", "Sandwiches"],
      ]
    )
  }
}

struct StubbedClock: NowProvider {
  var now: Date

  init(now: Date = .now) {
    self.now = now
  }
}
#endif
