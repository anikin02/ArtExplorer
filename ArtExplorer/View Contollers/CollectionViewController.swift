//
//  CollectionViewController.swift
//  ArtExplorer
//
//  Created by anikin02 on 09.04.2024.
//

import UIKit
import SnapKit

class CollectionViewController: UIViewController {
  let stackView = UIStackView()
  let collection: Collection
  
  init(collection: Collection) {
    self.collection = collection
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    stackView.axis = .horizontal
    stackView.alignment = .fill
    stackView.distribution = .fillEqually
    stackView.spacing = 10
    
    for art in collection.collection {
      if let image = UIImage(named: art.image) {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        stackView.addArrangedSubview(imageView)
      }
    }
    view.addSubview(stackView)
    
    stackView.snp.makeConstraints { make in
      make.centerX.equalTo(view.snp.centerX)
    }
  }
}
