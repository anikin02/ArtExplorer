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
  private var allStudyCollection = [Study]()
  private var searchStudyCollection = [Study]()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    DispatchQueue.main.async {
      self.allStudyCollection = APIManager.shared.getStudies()
    }
    
    // TEST DATA
    for i in 0...20 {
      allStudyCollection.append(Study(name: "Название \(i)", author: "Автор \(i)", text: "", link: ""))
    }
    //
    
    generateSafeArea()
    generateSearchBar()
    generateTableView()
    searchStudyCollection = APIManager.shared.getStudies()
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
  
  private func getSearchStudyCollection(key: String) -> [Study] {
    var result = [Study]()
    for study in allStudyCollection {
      if study.name.lowercased().contains(key.lowercased()) {
        result.append(study)
      }
    }
    return result
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    if let searchText = searchBar.text {
      searchStudyCollection = getSearchStudyCollection(key: searchText)
    }
    if searchStudyCollection.count > 0 {
      tableView.reloadData()
      searchBar.showsCancelButton = true
      if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton {
        cancelButton.setTitleColor(.systemPink, for: .normal)
      }
    } else {
      searchBar.text = ""
    }
    searchBar.resignFirstResponder()
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.text = ""
    searchStudyCollection = []
    searchBar.resignFirstResponder()
    tableView.reloadData()
    searchBar.setShowsCancelButton(false, animated: true)
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
    if searchStudyCollection.count > 0 {
      return searchStudyCollection.count
    } else {
      return allStudyCollection.count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
    
    if searchStudyCollection.count > 0 {
      cell.textLabel?.text = searchStudyCollection[indexPath.row].name
      cell.detailTextLabel?.text = searchStudyCollection[indexPath.row].author
    } else {
      cell.textLabel?.text = allStudyCollection[indexPath.row].name
      cell.detailTextLabel?.text = allStudyCollection[indexPath.row].author
    }
    
    return cell
  }

}
