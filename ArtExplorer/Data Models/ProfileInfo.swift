//
//  ProfileInfo.swift
//  ArtExplorer
//
//  Created by anikin02 on 08.04.2024.
//

import Foundation


class ProfileInfo {
  var collections: [Collection]
  
  init() {
    self.collections = []
  }
  
  init(collections: [Collection]) {
    self.collections = collections
  }
}
