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
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HTTPSearchView(
                    store: .init(
                        initialState: .init(),
                        reducer: {
                            SearchFeature()
                                ._printChanges()
                        }
                    )
                )
                .navigationTitle("Search Cat")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}
