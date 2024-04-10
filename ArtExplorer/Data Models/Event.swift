//
//  Event.swift
//  ArtExplorer
//
//  Created by anikin02 on 09.04.2024.
//

class Event {
  let name: String
  let location: String
  let date: String
  let description: String
  
  init(name: String, location: String, date: String, description: String) {
    self.name = name
    self.location = location
    self.date = date
    self.description = description
  }
}
