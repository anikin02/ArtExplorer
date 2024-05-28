//
//  APIData.swift
//  ArtExplorer
//
//  Created by anikin02 on 26.05.2024.
//

import Foundation

// MARK: - Objects
struct Objects: Codable {
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let id: Int
    let title: String
    let description: String?
    let artist_title: String?
    let style_id, style_title: String?
    let image_id: String?
    let date_end: Int?
}
