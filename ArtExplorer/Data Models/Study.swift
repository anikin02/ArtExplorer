//
//  Study.swift
//  ArtExplorer
//
//  Created by anikin02 on 08.04.2024.
//

import Foundation


class Study {
  let name: String
  let author: String
  let text: String
  let link: String
  let image: String
  // let date: String
  
  init(name: String, author: String, text: String, link: String, image: String) {
    self.name = name
    self.author = author
    self.text = text
    self.link = link
    self.image = image
  }
}
