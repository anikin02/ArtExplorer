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
  
  func getImage(imageURL: String, completion: @escaping (UIImage?) -> Void) {
    if let imageUrl = URL(string: imageURL) {
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
            let text = try String(element.getElementsByClass("sc-d56bc236-11 hYbLtW").first()?.text() ?? "")
            let link = try String(element.getElementsByClass("sc-d56bc236-10 tdBWn").first()?.text() ?? "")
            var imageURLString: String = ""
            if let imgElement = try element.getElementsByClass("sc-82db9615-2 jowSfL").first()?.select("img").first() {
              imageURLString = try String(imgElement.attr("src"))
            } else {
              imageURLString = ""
            }
            result.append(Study(name: name, author: author, text: text, link: link, image: imageURLString))
          }
          return result
        }
      }
    } catch let error { print(error) }
    
    return []
  }
  
  func getEvents() -> [Event]{
    let stringURL: String = "https://www.galleriesnow.net/exhibitions/europe/"
    guard let url = URL(string: stringURL) else { return [] }
    do {
      let htmlString = try String(contentsOf: url, encoding: .utf8)
      let htmlContent = htmlString
      
      do {
        let documet = try SwiftSoup.parse(htmlContent)
        do {
          let elements = try documet.getElementsByClass("exhibition-box")
          var result = [Event]()
          for element in elements {
            let name = try String(try element.getElementsByClass("extb-1").first()?.getElementsByClass("box-show-link glinks").first()?.text() ?? "")
            if name == "" {
              continue
            }
            let location = try String(element.getElementsByClass("citynameRow").first()?.text() ?? "")
            let description = try String(element.getElementsByClass("glinks snippet-text").first()?.text() ?? "")
            let date = try element.getElementsByClass("col-md-12").indices.contains(1) ? String(element.getElementsByClass("col-md-12")[1].text() ?? "") : ""
//            let link = try String(element.getElementsByClass("sc-d56bc236-10 tdBWn").first()?.text() ?? "")
            result.append(Event(name: name, location: location, date: date, description: description, link: ""))
          }
          return result
        }
      }
    } catch let error { print(error) }
    
    return []
  }
}
