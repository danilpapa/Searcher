//
//  HTTPSearcherTests.swift
//  HTTPSearcherTests
//
//  Created by setuper on 08.11.2025.
//

import XCTest
import SwiftUI
@testable import HTTPSearcher
import ComposableArchitecture

final class HTTPSearcherTests: XCTestCase {
    @MainActor
    func testSearchHttpSuccess() async {        
        let store = TestStore(initialState: SearchFeature.State()) {
            SearchFeature()
        } withDependencies: {
            $0.networkService = NetworkServicePreview()
        }
        
        await store.send(.binding(.set(\.request, "200"))) {
            $0.request = "200"
        }
        
        await store.send(.searchHttp)
        
        await store.receive(.addRecentCat(.init(image: .init(systemName: "star.fill"), statusCode: "777"))) {
            $0.recentCats = [HTTPCat(image: .init(systemName: "star.fill"), statusCode: "777")]
        }
        
        await store.receive(.clearQuery) {
            $0.request = ""
        }
    }
}
