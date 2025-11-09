//
//  HTTPCat.swift
//  HTTPSearcher
//
//  Created by setuper on 09.11.2025.
//

import SwiftUI

struct HTTPCat: Identifiable, Equatable {
    
    let id: UUID = .init()
    let image: Image
    let statusCode: String
}
