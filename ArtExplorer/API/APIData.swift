//
//  APIData.swift
//  ArtExplorer
//
//  Created by Данил Аникин on 26.05.2024.
//

import Foundation

// MARK: - ObjectIDs
struct ObjectIDs: Codable {
    let total: Int
    let objectIDs: [Int]
}

// MARK: - Object
struct Object: Codable {
    let objectID: Int
    let primaryImage: String
    let title: String
    let period, dynasty, reign, portfolio: String
    let artistDisplayName: String
    let objectDate: String
    let objectURL: String
}
