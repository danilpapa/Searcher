//
//  CatDetailView.swift
//  HTTPSearcher
//
//  Created by setuper on 09.11.2025.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct CatDetailFeature {
    
    @ObservableState
    struct State: Equatable {
        var cat: HTTPCat
    }
    
    enum Action {
        case showCatDetail(HTTPCat)
        case closeTapped
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case let .showCatDetail(cat):
            return .none
        case .closeTapped:
            return .none
        }
    }
}

struct CatDetailView: View {
    var store: StoreOf<CatDetailFeature>
    var body: some View {
        store.cat.image
    }
}
