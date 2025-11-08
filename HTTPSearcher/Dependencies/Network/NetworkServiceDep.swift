//
//  NetworkServiceDep.swift
//  HTTPSearcher
//
//  Created by setuper on 08.11.2025.
//

import Dependencies
import SwiftUI

private enum NetworkServiceKey: DependencyKey {
    
    static let liveValue: any INetworkService = NetworkServiceImpl()
    static let testValue: any INetworkService = NetworkServicePreview()
}

extension DependencyValues {
    
    var networkService: any INetworkService {
        get { self[NetworkServiceKey.self] }
        set { self[NetworkServiceKey.self] = newValue }
    }
}

final class NetworkServicePreview: INetworkService {
    func search(for code: String) async throws -> Image {
        try await Task.sleep(nanoseconds: 2_000_000_000)
        return Image(systemName: "star.fill")
    }
}
