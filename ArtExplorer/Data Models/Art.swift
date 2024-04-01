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
  var genre: String
  var date: Date // -> String
  var image: String // : ???
  
  init(name: String, author: String, genre: String, date: Date, image: String) {
    self.name = name
    self.author = author
    self.genre = genre
    self.date = date
    self.image = image
  }
  
}
