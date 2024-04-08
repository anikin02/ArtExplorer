//
//  Collection.swift
//  ArtExplorer
//
//  Created by anikin02 on 08.04.2024.
//

import Foundation

class Collection {
  var collection: [Art]
  var name: String
  
  init(collection: [Art], name: String) {
    self.collection = collection
    self.name = name
  }
}
