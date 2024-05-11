//
//  SearchArtsViewController.swift
//  ArtExplorer
//
//  Created by anikin02 on 11.05.2024.
//

import UIKit

class SearchArtsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
  private var tableView = UITableView()
  
  var searchArts: [Art]
  
  init(searchArts: [Art]) {
    self.searchArts = searchArts
    print(searchArts[0].name)
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    view.backgroundColor = .white
    
    generateTableView()
  }
  
  private func generateTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.allowsSelection = true
    tableView.isUserInteractionEnabled = true
    tableView.showsVerticalScrollIndicator = false
    view.addSubview(tableView)
    tableView.snp.makeConstraints { maker in
      maker.top.left.right.bottom.equalToSuperview()
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return searchArts.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
    
    cell.textLabel?.text = searchArts[indexPath.row].name
    cell.detailTextLabel?.text = searchArts[indexPath.row].author
    
    return cell
  }
}
