//
//  HTTPCat.swift
//  HTTPSearcher
//
//  Created by setuper on 09.11.2025.
//

import SwiftUI
import Dependencies

struct HTTPCat: Identifiable, Equatable {
    
    let image: Image
    let statusCode: String
    
    var id: String {
        statusCode
    }
}
