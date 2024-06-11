//
//  ContentView.swift
//  TabBarDemo
//
//  Created by Kuba Kociucki on 11/06/2024.
//

import SwiftUI

enum Year: Identifiable, Hashable {
	case thisYear, lastYear, yearBefor
	
	var id: Self { self }

	var yearString: String {
		switch self {
		case .thisYear:
			"2024"
		case .lastYear:
			"2023"
		case .yearBefor:
			"2022"
		}
	}
}

enum Pet: String, Identifiable, Hashable {
	case dog, fish, tortoise

	var id: Self { self }
}

enum NavTabs: Equatable, Hashable, Identifiable {
	case photos, music, movies, games, books, search
	case year(Year)
	case pet(Pet)

	var id: Self {
		self
	}

	var label: String {
		switch self {
		case .photos:
			"Photos"
		case .music:
			"Music"
		case .movies:
			"Movies"
		case .games:
			"Games"
		case .books:
			"Books"
		case .search:
			""
		case .year(let year):
			year.yearString
		case .pet(let pet):
			pet.rawValue.capitalized
		}
	}

	var viewContent: String {
		switch self {
		case .photos:
			"Photos Tab"
		case .music:
			"Music Tab"
		case .movies:
			"Movies Tab"
		case .games:
			"Games Tab"
		case .books:
			"Books Tab"
		case .search:
			"Search Tab"
		case .year(let year):
			"Tab for year: \(year.yearString)"
		case .pet(let pet):
			"\(pet.rawValue.capitalized)'s Tab"
		}
	}

	var systemImage: String {
		switch self {
		case .photos:
			"photo"
		case .music:
			"music.note"
		case .movies:
			"popcorn"
		case .games:
			"gamecontroller"
		case .books:
			"book"
		case .search:
			""
		case .year(_):
			"calendar"
		case .pet(let pet):
			pet.rawValue
		}
	}
	
}

struct ContentView: View {
	@AppStorage("tabViewCustomization") var tabViewCustomization: TabViewCustomization
	@State private var selectedTab: NavTabs = .photos

	var body: some View {
		TabView(selection: $selectedTab) {
			Tab(NavTabs.photos.label, systemImage: NavTabs.photos.systemImage, value: .photos) {
				Text(NavTabs.photos.viewContent)
			}
			.customizationID(NavTabs.photos.systemImage)
			.customizationBehavior(.disabled, for: .sidebar)
			Tab(NavTabs.music.label, systemImage: NavTabs.music.systemImage, value: .music) {
				Text(NavTabs.music.viewContent)
			}
			.customizationID(NavTabs.music.systemImage)
			.customizationBehavior(.disabled, for: .sidebar)
			Tab(NavTabs.movies.label, systemImage: NavTabs.movies.systemImage, value: .movies) {
				Text(NavTabs.movies.viewContent)
			}
			.customizationID(NavTabs.movies.systemImage)
			Tab(NavTabs.games.label, systemImage: NavTabs.games.systemImage, value: .games) {
				Text(NavTabs.games.viewContent)
			}
			.customizationID(NavTabs.games.systemImage)
			Tab(NavTabs.books.label, systemImage: NavTabs.books.systemImage, value: .books) {
				Text(NavTabs.books.viewContent)
			}
			.customizationID(NavTabs.books.systemImage)
			TabSection("Years") {
				Tab(
					NavTabs.year(.thisYear).label,
					systemImage: NavTabs.year(.thisYear).systemImage,
					value: NavTabs.year(.thisYear)
				) {
					Text(NavTabs.year(.thisYear).viewContent)
				}
				.customizationID(Year.thisYear.yearString)
				Tab(
					NavTabs.year(.lastYear).label,
					systemImage: NavTabs.year(.lastYear).systemImage,
					value: NavTabs.year(.lastYear)
				) {
					Text(NavTabs.year(.lastYear).viewContent)
				}
				.customizationID(Year.lastYear.yearString)
				Tab(
					NavTabs.year(.yearBefor).label,
					systemImage: NavTabs.year(.yearBefor).systemImage,
					value: NavTabs.year(.yearBefor)
				) {
					Text(NavTabs.year(.yearBefor).viewContent)
				}
				.customizationID(Year.yearBefor.yearString)
			}
			.defaultVisibility(.hidden, for: .tabBar)
			.sectionActions {
				Button("Add year", systemImage: "calendar.badge.plus") {}
			}
			TabSection("Pets") {
				Tab(
					NavTabs.pet(.dog).label,
					systemImage: NavTabs.pet(.dog).systemImage,
					value: NavTabs.pet(.dog)
				) {
					Text(NavTabs.pet(.dog).viewContent)
				}
				.customizationID(Pet.dog.rawValue)
				Tab(
					NavTabs.pet(.fish).label,
					systemImage: NavTabs.pet(.fish).systemImage,
					value: NavTabs.pet(.fish)
				) {
					Text(NavTabs.pet(.fish).viewContent)
				}
				.customizationID(Pet.fish.rawValue)
				Tab(
					NavTabs.pet(.tortoise).label,
					systemImage: NavTabs.pet(.tortoise).systemImage,
					value: NavTabs.pet(.tortoise)
				) {
					Text(NavTabs.pet(.tortoise).viewContent)
				}
				.customizationID(Pet.tortoise.rawValue)
			}
			.defaultVisibility(.hidden, for: .tabBar)
			Tab(value: .search, role: .search) {
				Text(NavTabs.search.viewContent)
			}
		}
		.tabViewStyle(.sidebarAdaptable)
		.tabViewCustomization($tabViewCustomization)
	}
}

#Preview {
	ContentView()
		.preferredColorScheme(.dark)
}
