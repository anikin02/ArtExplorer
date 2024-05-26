//
//  RecommendationsViewController.swift
//  ArtExplorer
//
//  Created by anikin02 on 01.04.2024.
//

import UIKit
import SnapKit

class RecommendationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
  
  private var tableView = UITableView()
  private var addInCollectionButton = UIButton()
  private var searchBar = UISearchBar()
  
  private var ids: [Int] = []
  private var arts: [Art] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    APIManager.shared.getObject(id: 15305) { [weak self] value in
      DispatchQueue.main.async {
        guard let self else { return }
        self.arts.append(value)
        self.tableView.reloadData()
      }
    }
    APIManager.shared.getObject(id: 10958) { [weak self] value in
      DispatchQueue.main.async {
        guard let self else { return }
        self.arts.append(value)
        self.tableView.reloadData()
      }
    }
    APIManager.shared.getObject(id: 283095) { [weak self] value in
      DispatchQueue.main.async {
        guard let self else { return }
        self.arts.append(value)
        self.tableView.reloadData()
      }
    }
    
//    APIManager.shared.getObjectIDs() { [weak self] values in 
//      guard let self else { return }
//      self.ids = values
//      for id in ids {
//        APIManager.shared.getObject(id: id) { [weak self] value in
//          guard let self else { return }
//          self.arts.append(value)
//        }
//        if arts.count > 50 {
//          break
//        }
//      }
//      tableView.reloadData()
//    }
    
    generateSafeArea()
    generateSearchBar()
    generateTableView()
    generateAddInCollectionButton()
  }
  
  // MARK: - Search Bar
  private func generateSearchBar() {
    searchBar.delegate = self
    searchBar.placeholder = "Search..."
    view.addSubview(searchBar)
    
    searchBar.snp.makeConstraints { maker in
      maker.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      maker.left.right.equalToSuperview()
    }
  }
  
  private func getSearchArtCollection(key: String) -> [Art] {
    var result = [Art]()
    for art in arts {
      if art.name.lowercased().contains(key.lowercased()) ||
          art.author.lowercased().contains(key.lowercased()) ||
          art.genre.lowercased().contains(key.lowercased()) {
        result.append(art)
      }
    }
    return result
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    var searchArtCollection = [Art]()
    if let searchText = searchBar.text {
      searchArtCollection = getSearchArtCollection(key: searchText)
    }
    
    if searchArtCollection.count > 0 {
      let searchView = CollectionViewController(collection: Collection(collection: searchArtCollection, name: ""))
      
      present(searchView, animated: true)
      searchBar.text = ""
    }
    searchBar.resignFirstResponder()
  }
//  
//  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//    searchBar.text = ""
//    searchStudyCollection = []
//    searchBar.resignFirstResponder()
//    tableView.reloadData()
//    searchBar.setShowsCancelButton(false, animated: true)
//  }
//  
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
  
  // MARK: - Button
  private func generateAddInCollectionButton() {
    let image = UIImage(systemName: "plus.circle")
    addInCollectionButton.setBackgroundImage(image, for: .normal)
    addInCollectionButton.tintColor = .systemPink
    addInCollectionButton.addTarget(self, action: #selector(addInCollectionButtonTapped), for: .touchUpInside)
    addInCollectionButton.imageView?.contentMode = .scaleAspectFit
    
    view.addSubview(addInCollectionButton)
    addInCollectionButton.snp.makeConstraints { make in
      make.bottom.equalTo(tableView.snp.bottom).offset(-85)
      make.right.equalToSuperview().offset(-15)
      make.width.equalTo(50)
      make.height.equalTo(50)
    }
  }
  
  @objc private func addInCollectionButtonTapped() {
    guard let visibleIndexPath = tableView.indexPathsForVisibleRows?.first else {
      return
    }
    let addInCollectionViewController = AddInCollectionViewController()
    addInCollectionViewController.art = arts[visibleIndexPath.row]
    present(addInCollectionViewController, animated: true)
  }
  
  // MARK: - Table View
  private func generateTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.isPagingEnabled = true
    tableView.allowsSelection = false
    tableView.showsVerticalScrollIndicator = false
    view.addSubview(tableView)
    tableView.snp.makeConstraints { maker in
      maker.top.equalTo(searchBar.snp.bottom)
      maker.left.right.bottom.equalToSuperview()
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return arts.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return RecomendationTableViewCell(art: arts[indexPath.row])
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return view.frame.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom
  }

}
