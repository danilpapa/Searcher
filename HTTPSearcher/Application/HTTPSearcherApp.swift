//
//  HTTPSearcherApp.swift
//  HTTPSearcher
//
//  Created by setuper on 08.11.2025.
//

import SwiftUI
import ComposableArchitecture

@main
struct HTTPSearcherApp: App {
    let store: StoreOf<SearchFeature> = .init(
        initialState: .init(),
        reducer: {
            SearchFeature()
                ._printChanges()
        }
    )
    
    var body: some Scene {
        WindowGroup {
            TabView {
                Tab("http cat", systemImage: "cat") {
                    NavigationStack {
                        HTTPSearchView(store: store)
                            .navigationTitle("Search Cat")
                            .navigationBarTitleDisplayMode(.inline)
                    }
                }
            }
            .tabViewBottomAccessory {
                WithViewStore(store) { $0 } content: { store in
                    if let lastCat = store.recentCats.last {
                        Button("Show last cat") {
                            store.send(.detail(.presented(.showCatDetail(store.state.recentCats.last!))))
                        }
                    }
                }
            }
        }
    }
}

