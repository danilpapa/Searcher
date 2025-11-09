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
    
    enum Action: Equatable {
        case showCatDetail(HTTPCat)
        case closeTapped
        case removeCat
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case let .showCatDetail(_):
            return .none
        case .closeTapped:
            return .none
        case .removeCat:
            return .run { send in
                await send(.closeTapped)
            }
        }
    }
}

struct CatDetailView: View {
    var store: StoreOf<CatDetailFeature>
    var body: some View {
        VStack {
            store.cat.image
            Button("Remove that http") {
                store.send(.removeCat)
            }
        }
    }
}
