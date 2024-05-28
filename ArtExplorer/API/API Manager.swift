//
//  API Manager.swift
//  ArtExplorer
//
//  Created by Данил Аникин on 26.05.2024.
//

import Foundation
import UIKit
import SwiftSoup

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
  
  func getImage(imageID: String, completion: @escaping (UIImage?) -> Void) {
    if let imageUrl = URL(string: "https://www.artic.edu/iiif/2/\(imageID)/full/843,/0/default.jpg") {
      DispatchQueue.global().async {
        if let imageData = try? Data(contentsOf: imageUrl) {
          DispatchQueue.main.async {
            completion(UIImage(data: imageData))
          }
        }
      }
    }
  }
  
  func getStudies() -> [Study]{
    let stringURL: String = "https://aeon.co/culture/art"
    guard let url = URL(string: stringURL) else { return [] }
    do {
      let htmlString = try String(contentsOf: url, encoding: .utf8)
      let htmlContent = htmlString
      
      do {
        let documet = try SwiftSoup.parse(htmlContent)
        do {
          let elements = try documet.getElementsByClass("sc-d56bc236-9 iGZwDd")
          var result = [Study]()
          for element in elements {
            let name = try String(element.getElementsByClass("sc-d56bc236-10 tdBWn").first()?.text() ?? "")
            let author = try String(element.getElementsByClass("sc-d56bc236-0 sc-d56bc236-12 iOJnhy dFhhBp").first()?.text() ?? "Without the author")
            let text = try String(element.getElementsByClass("sc-d56bc236-10 tdBWn").first()?.text() ?? "")
            let link = try String(element.getElementsByClass("sc-d56bc236-10 tdBWn").first()?.text() ?? "")
            result.append(Study(name: name, author: author, text: text, link: link))
          }
          return result
        }
      }
    } catch let error { print(error) }
    
    return []
  }
}
