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
        var recentCats: [HTTPCat] = []
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case searchHttp
        case addRecentCat(HTTPCat)
    }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .searchHttp:
                let queryCode = state.request
                return .run { send in
                    do {
                        let cat = try await network.search(for: queryCode)
                        await send(.addRecentCat(cat))
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            case let .addRecentCat(cat):
                state.recentCats.append(cat)
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
                ForEach(store.recentCats) { cat in
                    catCell(
                        image: cat.image,
                        error: cat.statusCode
                    )
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
    
    func catCell(image: Image, error: String) -> some View {
        HStack {
            image
                .resizable()
                .scaledToFit()
                .frame(maxHeight: UIScreen.main.bounds.width / 4)
            Text(error)
        }
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
