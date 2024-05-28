//
//  RecomendationTableViewCell.swift
//  ArtExplorer
//
//  Created by anikin02 on 02.04.2024.
//

import UIKit
import SnapKit
import SDWebImage

class RecomendationTableViewCell: UITableViewCell {
  
  private var art: Art
  
  private var nameLabel = UILabel()
  private var authorLabel = UILabel()
  private var descriptionButton = UIButton(type: .system)
  
  
  init(art: Art) {
    self.art = art
    super.init(style: .default, reuseIdentifier: "RecomendationTableViewController")
    self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    initialize()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func initialize() {
    nameLabel.text = art.name
    authorLabel.text = art.author
    descriptionButton.setTitle("Learn More", for: .normal)
    descriptionButton.sizeToFit()
    descriptionButton.tintColor = .systemPink
    
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    //guard let url = URL(string: "https://www.artic.edu/iiif/2/\(art.image)/full/843,/0/default.png") else { return }
    
    if let imageUrl = URL(string: "https://www.artic.edu/iiif/2/\(art.image)/full/843,/0/default.jpg") {
        // Загружаем изображение с использованием URL
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: imageUrl) {
                // Создаем UIImage из загруженных данных и устанавливаем его в UIImageView
                DispatchQueue.main.async {
                    imageView.image = UIImage(data: imageData)
                }
            }
        }
    }
    
    contentView.addSubview(imageView)
    contentView.addSubview(nameLabel)
    contentView.addSubview(authorLabel)
    contentView.addSubview(descriptionButton)
    
    
    nameLabel.font = UIFont.boldSystemFont(ofSize: 35)
    
    imageView.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.centerX.equalTo(contentView.snp.centerX)
      make.height.lessThanOrEqualTo(contentView.snp.height).offset(-230)
    }
    
    nameLabel.snp.makeConstraints { make in
      make.top.equalTo(imageView.snp.bottom).offset(5)
      make.leading.equalTo(contentView.snp.leading).offset(16)
      make.trailing.equalTo(contentView.snp.trailing).offset(-16)
    }
    
    authorLabel.snp.makeConstraints { make in
      make.top.equalTo(nameLabel.snp.bottom).offset(8)
      make.leading.equalTo(contentView.snp.leading).offset(16)
      make.trailing.equalTo(contentView.snp.trailing).offset(-16)
    }
    
    descriptionButton.snp.makeConstraints { make in
      make.top.equalTo(authorLabel.snp.bottom).offset(8)
      make.leading.equalTo(contentView.snp.leading).offset(16)
    }
  }
}
