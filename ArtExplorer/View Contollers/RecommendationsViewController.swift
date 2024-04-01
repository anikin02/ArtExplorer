//
//  RecommendationsViewController.swift
//  ArtExplorer
//
//  Created by anikin02 on 01.04.2024.
//

import UIKit
import SnapKit

class RecommendationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  private var tableView = UITableView()
  
  private var arts: [Art] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.isPagingEnabled = true
    tableView.showsVerticalScrollIndicator = false
    
    tableView.snp.makeConstraints{ maker in
      maker.edges.equalToSuperview()
    }
    
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return arts.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }

}
