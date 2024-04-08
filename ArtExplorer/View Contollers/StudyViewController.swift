//
//  StudyViewController.swift
//  ArtExplorer
//
//  Created by anikin02 on 01.04.2024.
//

import UIKit

class StudyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
  
  private var tableView = UITableView()
  private let searchBar = UISearchBar()
  private var studyCollection = [Study]()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    // TEST DATA
    for i in 0...10 {
      studyCollection.append(Study(name: "Название \(i)", author: "Автор \(i)", text: ""))
    }
    //
    
    generateSafeArea()
    generateSearchBar()
    generateTableView()
    
  }
  
  private func generateSafeArea() {
    let safeAreaView = UIView()
    safeAreaView.backgroundColor = .white

    view.addSubview(safeAreaView)
    safeAreaView.snp.makeConstraints { maker in
      maker.top.equalTo(view.snp.top)
      maker.left.right.equalToSuperview()
      maker.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
    }
  }
  
  private func generateSearchBar() {
    searchBar.delegate = self
    searchBar.placeholder = "Search..."
    view.addSubview(searchBar)
    
    searchBar.snp.makeConstraints { maker in
      maker.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      maker.left.right.equalToSuperview()
    }
  }
  
  private func generateTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.allowsSelection = false
    tableView.showsVerticalScrollIndicator = false
    view.addSubview(tableView)
    tableView.snp.makeConstraints { maker in
      maker.top.equalTo(searchBar.snp.bottom)
      maker.left.right.bottom.equalToSuperview()
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return studyCollection.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        
    cell.textLabel?.text = studyCollection[indexPath.row].name
    
    cell.detailTextLabel?.text = studyCollection[indexPath.row].author
    
    return cell
  }

}
