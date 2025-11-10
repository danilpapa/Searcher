//
//  Sample.swift
//  HTTPSearcher
//
//  Created by setuper on 10.11.2025.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct SampleFeature {
    
    @ObservableState
    struct State {
        var cnt: Int = 0
    }
    
    enum Action {
        case inc
        case dec
    }
    
    func reduce(
        into state: inout State,
        action: Action
    ) -> Effect<Action> {
        switch action {
        case .inc:
            state.cnt += 1
            return .none
        case .dec:
            state.cnt -= 1
            return .none
        }
    }
}

struct Sample: View {
    @State var store: StoreOf<SampleFeature>
    var body: some View {
        Text(store.cnt.description)
        Button("inc") {
            store.send(.inc)
        }
        Button("dec") {
            store.send(.dec)
        }
    }
}

#Preview {
    Sample(
        store: .init(
            initialState: .init(),
            reducer: {
                SampleFeature()
            }
        )
    )
}
