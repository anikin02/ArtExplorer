//
//  DataModel.swift
//  ArtExplorer
//
//  Created by anikin02 on 06.05.2024.
//

import Foundation

class DataModel {
  static var collections = [Collection]()
  
  static func loadCollections() {
    let collection1 = Collection(collection: [Art(name: "Моно Лиза", author: "Леонардо Да Винчи", description: "Описание", genre: "Какой-то", date: "1503", image: "testImage1"), Art(name: "Звездная ночь", author: "Ван Гог", description: "Описание", genre: "Какой-то", date: "Июнь 1889 – Июль 1889", image: "testImage2")], name: "Любимое Ван Гог")
    let collection2 = Collection(collection: [Art(name: "Звездная ночь", author: "Ван Гог", description: "Описание", genre: "Какой-то", date: "Июнь 1889 – Июль 1889", image: "testImage2")], name: "Любимое Леонадро Да Винчи")
    DataModel.collections = [
      collection1,
      collection2,
      Collection(collection: [], name: "Портреты"),
      Collection(collection: [], name: "Кубизм"),
      Collection(collection: [], name: "Пейзажи"),
      Collection(collection: [], name: "Современное")
    ]
  }
  
  static func removeCollection(_ collection: Collection) {
    if let index = collections.firstIndex(where: { $0.name == collection.name }) {
      collections.remove(at: index)
    }
  }
}
