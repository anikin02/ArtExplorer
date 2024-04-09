//
//  RecomendationTableViewCell.swift
//  ArtExplorer
//
//  Created by anikin02 on 02.04.2024.
//

import UIKit
import SnapKit

class RecomendationTableViewCell: UITableViewCell {
  
  private var art: Art
  
  private var nameLabel = UILabel()
  private var authorLabel = UILabel()
  private var dateLabel = UILabel()
  private var descriptionLabel = UILabel()
  
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
    dateLabel.text = art.date
    descriptionLabel.text = art.description
    
    let imageView = UIImageView()
    imageView.image = UIImage(named: art.image)
    imageView.contentMode = .scaleAspectFit
    contentView.addSubview(imageView)
    
    contentView.addSubview(nameLabel)
    contentView.addSubview(authorLabel)
    contentView.addSubview(dateLabel)
    contentView.addSubview(descriptionLabel)
    
    nameLabel.font = UIFont.boldSystemFont(ofSize: 35)
    
    imageView.snp.makeConstraints { make in
      make.top.equalTo(contentView.snp.top).offset(8)
      make.leading.equalToSuperview()
      make.trailing.equalToSuperview()
      make.height.lessThanOrEqualTo(contentView.snp.height).offset(-125)
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
    
    dateLabel.snp.makeConstraints { make in
      make.top.equalTo(authorLabel.snp.bottom).offset(8)
      make.leading.equalTo(contentView.snp.leading).offset(16)
      make.trailing.equalTo(contentView.snp.trailing).offset(-16)
    }
    
    descriptionLabel.snp.makeConstraints { make in
      make.top.equalTo(dateLabel.snp.bottom).offset(8)
      make.leading.equalTo(contentView.snp.leading).offset(16)
      make.trailing.equalTo(contentView.snp.trailing).offset(-16)
    }

    
  }
  
}
