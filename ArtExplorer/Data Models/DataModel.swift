//
//  DataModel.swift
//  ArtExplorer
//
//  Created by anikin02 on 06.05.2024.
//

import Foundation

class DataModel {
  static var objectIDs: [Int] = []
  static var arts: [Art] = []
  static var collections = [Collection]()
  static var recomendationKeys = [String]()
  
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
  
  static func parseArt(objects: [Datum]) {
    print("start")
    for object in objects {
      if let _ = object.image_id {
        print(object.artist_title ?? "Without the author", "-", object.image_id ?? "")
        self.arts.append(Art(name: object.title,
                             author: object.artist_title ?? "Without the author",
                             description: object.description ?? "",
                             genre: object.style_title ?? "",
                             date: String(object.date_end ?? 0),
                             image: object.image_id ?? ""))
      }
    }
    print("end")
  }
  
  static func removeCollection(_ collection: Collection) {
    if let index = collections.firstIndex(where: { $0.name == collection.name }) {
      collections.remove(at: index)
    }
  }
}
