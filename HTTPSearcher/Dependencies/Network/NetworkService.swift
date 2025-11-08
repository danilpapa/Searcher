//
//  NetworkService.swift
//  HTTPSearcher
//
//  Created by setuper on 08.11.2025.
//

import Alamofire
import SwiftUI
import UIKit
import Foundation
import Dependencies

protocol INetworkService {
    
    func search(for code: String) async throws -> HTTPCat
}

final class NetworkServiceImpl: INetworkService {
    
    func search(for code: String) async throws -> HTTPCat {
        guard let url = Endpoint.httpCat(code).url else {
            throw NetworkServiceError.creatingURL
        }
        let data = try await AF
            .request(url, method: .get)
            .validate()
            .serializingData()
            .value
        
        guard let image = UIImage(data: data) else {
            throw NetworkServiceError.dataToUIImage
        }
        return HTTPCat(image: Image(uiImage: image), statusCode: code)
    }
}

enum NetworkServiceError: Error {
    
    case creatingURL
    case dataToUIImage
}

enum Endpoint {
    
    case httpCat(String)
    
    var url: URL? {
        switch self {
        case let .httpCat(code):
            return .init(string: "https://http.cat/\(code)") ?? nil
        }
    }
}
