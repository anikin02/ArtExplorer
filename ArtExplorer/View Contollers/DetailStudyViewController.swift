//
//  DetailStudyViewController.swift
//  ArtExplorer
//
//  Created by anikin02 on 29.05.2024.
//

import Foundation
import UIKit

class DetailStudyViewController: UIViewController {
  private let study: Study
  
  private let nameLabel = UILabel()
  private let authorLabel = UILabel()
  private let descriptionLabel = UILabel()
  private let linkLabel = UILabel()
  
  init(study: Study) {
    self.study = study
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    initialize()
  }
  
  private func initialize() {
    
    let imageView = UIImageView()
//    APIManager.shared.getImage(imageURL: study.image) { image in
//      imageView.image = image
//    }
    imageView.image = UIImage(named:"testImage2")
    imageView.contentMode = .scaleAspectFit
    
    view.addSubview(imageView)
    imageView.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(20)
      make.left.equalToSuperview().offset(20)
      make.right.equalToSuperview().offset(-20)
      make.width.equalTo(view.snp.width).offset(-40)
    }
    
    nameLabel.text = study.name
    nameLabel.font = UIFont.boldSystemFont(ofSize: 35)
    nameLabel.numberOfLines = 0
    nameLabel.lineBreakMode = .byWordWrapping
    
    authorLabel.text = study.author
    authorLabel.font = UIFont.boldSystemFont(ofSize: 25)
    authorLabel.numberOfLines = 0
    authorLabel.lineBreakMode = .byWordWrapping
    
    descriptionLabel.text = study.text
    descriptionLabel.numberOfLines = 0
    descriptionLabel.lineBreakMode = .byWordWrapping
    
    linkLabel.text = study.link
    
    view.addSubview(nameLabel)
    nameLabel.snp.makeConstraints { make in
      make.top.equalTo(imageView.snp.bottom).offset(10)
      make.left.equalToSuperview().offset(20)
      make.right.lessThanOrEqualTo(view.snp.right).offset(-20)
    }
    
    view.addSubview(authorLabel)
    authorLabel.snp.makeConstraints { make in
      make.top.equalTo(nameLabel.snp.bottom).offset(10)
      make.left.equalToSuperview().offset(20)
      make.right.lessThanOrEqualTo(view.snp.right).offset(-20)
    }
    
    view.addSubview(descriptionLabel)
    descriptionLabel.snp.makeConstraints { make in
      make.top.equalTo(authorLabel.snp.bottom).offset(10)
      make.left.equalToSuperview().offset(20)
      make.right.lessThanOrEqualTo(view.snp.right).offset(-20)
    }
  }
}
