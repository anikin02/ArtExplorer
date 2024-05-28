//
//  EventsViewControllerCell.swift
//  ArtExplorer
//
//  Created by anikin02 on 09.04.2024.
//

import UIKit
import SnapKit

class EventsViewControllerCell: UITableViewCell {
  
  private var event: Event
  
  private var nameLabel = UILabel()
  private var locationLabel = UILabel()
  private var dateLabel = UILabel()
  private var imageLocationView = UIImageView()
  
  init(event: Event) {
    self.event = event
    super.init(style: .default, reuseIdentifier: "EventsViewController")
    
    initialize()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func initialize() {
    nameLabel.text = event.name
    locationLabel.text = event.location
    dateLabel.text = event.date
    imageLocationView.image = UIImage(systemName: "location")
    imageLocationView.contentMode = .scaleAspectFit
    imageLocationView.tintColor = .systemPink
    
    contentView.addSubview(dateLabel)
    
    dateLabel.snp.makeConstraints { make in
      make.centerY.equalTo(contentView.snp.centerY)
      make.right.equalTo(contentView.snp.right).offset(-20)
    }
    
    contentView.addSubview(nameLabel)
    nameLabel.snp.makeConstraints { make in
      make.top.equalTo(contentView.snp.top).offset(10)
      make.left.equalTo(contentView.snp.left).offset(20)
      make.right.lessThanOrEqualTo(dateLabel.snp.left).offset(-10)
    }
    
    contentView.addSubview(imageLocationView)
    
    imageLocationView.snp.makeConstraints { make in
      make.top.equalTo(nameLabel.snp.bottom).offset(4)
      make.left.equalTo(contentView.snp.left).offset(20)
    }
    
    locationLabel.font = UIFont.systemFont(ofSize: 13)
    contentView.addSubview(locationLabel)
    
    locationLabel.snp.makeConstraints { make in
      make.centerY.equalTo(imageLocationView.snp.centerY)
      make.left.equalTo(imageLocationView.snp.right)
    }
  }
}
