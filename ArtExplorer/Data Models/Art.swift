//
//  Art.swift
//  ArtExplorer
//
//  Created by anikin02 on 01.04.2024.
//

import Foundation
import UIKit

class Art {
  let name: String
  let author: String
  let description: String
  let genre: String
  let date: String
  let image: String
  var imageData: UIImage?
  
  init(name: String, author: String, description: String, genre: String, date: String, image: String) {
    self.name = name
    self.author = author
    self.description = description
    self.genre = genre
    self.date = date
    self.image = image
  }
  
}
