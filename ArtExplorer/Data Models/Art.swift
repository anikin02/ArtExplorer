//
//  Art.swift
//  ArtExplorer
//
//  Created by anikin02 on 01.04.2024.
//

import Foundation

class Art {
  var name: String
  var author: String
  var description: String
  var genre: String
  var date: String
  var image: String // : ???
  
  init(name: String, author: String, description: String, genre: String, date: String, image: String) {
    self.name = name
    self.author = author
    self.description = description
    self.genre = genre
    self.date = date
    self.image = image
  }
  
}
