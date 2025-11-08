//
//  HTTPSearchView.swift
//  HTTPSearcher
//
//  Created by setuper on 08.11.2025.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct SearchFeature {
    @Dependency(\.networkService) var network
    
    @ObservableState
    struct State {
        var request: String = ""
        var recentCats: [Image] = []
        var isLoading: Bool = false
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case searchHttp
        case addRecentImage(Image)
    }
    
    // вот тут баг я ебал ReducerOf<> - нельзя нахуй
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .searchHttp:
                guard !state.request.isEmpty else { return .none }
                state.isLoading = true
                let queryCode = state.request
                return .run { send in
                    do {
                        let image = try await network.search(for: queryCode)
                        await send(.addRecentImage(image))
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            case let .addRecentImage(image):
                state.recentCats.append(image)
                return .none
            case .binding:
                return .none
            }
        }
    }
}

struct HTTPSearchView: View {
    @State var store: StoreOf<SearchFeature>
    var body: some View {
        VStack {
            List {
                ForEach(store.recentCats.indices, id: \.self) { imageIndex in
                    Text(imageIndex.description)
                }
            }
            .overlay(alignment: .center) {
                Text("No recent cats")
                    .foregroundStyle(.gray)
                    .fontWeight(.semibold)
                    .font(.title3)
                    .opacity(store.recentCats.isEmpty ? 1 : 0)
            }
            .toolbar {
                TextField("Http code", text: $store.request)
                    .onSubmit {
                        store.send(.searchHttp)
                    }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
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
