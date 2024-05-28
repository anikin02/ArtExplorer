//
//  API Manager.swift
//  ArtExplorer
//
//  Created by Данил Аникин on 26.05.2024.
//

import Foundation

class APIManager {
  static let shared = APIManager()
  
  func getObjects(completion: @escaping ([Datum]) -> Void ) {
    let urlString: String = "https://api.artic.edu/api/v1/artworks?limit=100"
    guard let url = URL(string: urlString) else { return }
    
    let request = URLRequest(url: url)
    
    let task = URLSession.shared.dataTask(with: request) { data, response,error in
      guard let data = data else { return }
      if let objects = try? JSONDecoder().decode(Objects.self, from: data) {
        completion(objects.data)
      } else {
        print("some error")
      }
    }
    task.resume()
  }
  
//  func getObjectIDs(completion: @escaping ([Int]) -> Void ) {
//    let urlString: String = "https://collectionapi.metmuseum.org/public/collection/v1/search?hasImages=true&q=love"
//    guard let url = URL(string: urlString) else { return }
//    let request = URLRequest(url: url)
//    
//    let task = URLSession.shared.dataTask(with: request) { data, response, error in
//      guard let data = data else { return }
//      if let objectIDs = try? JSONDecoder().decode(ObjectIDs.self, from: data) {
//        completion(objectIDs.objectIDs)
//      } else {
//        print("ERROR")
//      }
//    }
//    task.resume()
//  }
//  
//  func getObject(id: Int, completion: @escaping (Art) -> Void ) {
//    let urlString: String = "https://collectionapi.metmuseum.org/public/collection/v1/objects/\(id)"
//    guard let url = URL(string: urlString) else { return }
//    let request = URLRequest(url: url)
//    let task = URLSession.shared.dataTask(with: request) { data, response, error in
//      guard let data = data else { return }
//      if let object = try? JSONDecoder().decode(Object.self, from: data) {
//        if object.primaryImageSmall != "" && object.artistDisplayName != "" {
//          let art = Art(name: object.title,
//                        author: object.artistDisplayName,
//                        description: "",
//                        genre: "",
//                        date: object.objectDate,
//                        image: object.primaryImageSmall)
//          completion(art)
//        }
//      } else {
//        print("ERROR")
//      }
//    }
//    task.resume()
//  }
}
