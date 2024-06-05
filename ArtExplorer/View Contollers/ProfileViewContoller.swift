//
//  ProfileViewContoller.swift
//  ArtExplorer
//
//  Created by anikin02 on 01.04.2024.
//

import UIKit
import SnapKit

class ProfileViewContoller: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UIViewControllerTransitioningDelegate {
  
  private var tableView = UITableView()
  private let searchBar = UISearchBar()
  private let addCollectionButton = UIButton()
  private var searchCollections = [Collection]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    generateSafeArea()
    generateSearchBar()
    generateTableView()
    generateAddCollectionButton()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
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
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    if let searchText = searchBar.text {
      searchCollections = getSearchCollection(key: searchText)
    }
    if searchCollections.count > 0 {
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
    searchCollections = []
    searchBar.resignFirstResponder()
    tableView.reloadData()
    searchBar.setShowsCancelButton(false, animated: true)
  }
  
  private func generateAddCollectionButton() {
    let image = UIImage(systemName: "plus.circle")
    addCollectionButton.setBackgroundImage(image, for: .normal)
    addCollectionButton.tintColor = .systemPink
    addCollectionButton.addTarget(self, action: #selector(addCollectionButtonTapped), for: .touchUpInside)
    addCollectionButton.imageView?.contentMode = .scaleAspectFit
    
    view.addSubview(addCollectionButton)
    
    addCollectionButton.snp.makeConstraints { maker in
      maker.bottom.equalTo(tableView.snp.bottom).offset(-85)
      maker.right.equalToSuperview().offset(-15)
      maker.width.equalTo(50)
      maker.height.equalTo(50)
    }
  }
  
  @objc func addCollectionButtonTapped() {
    let addCollectionViewController = AddCollectionViewController()
    addCollectionViewController.onSave = { name in
      DataModel.collections.append(Collection(collection: [], name: name))
      self.tableView.reloadData()
    }
    present(addCollectionViewController, animated: true)
  }
  
  func getSearchCollection(key: String) -> [Collection] {
    var result = [Collection]()
    for collection in DataModel.collections {
      if collection.name.lowercased().contains(key.lowercased()) {
        result.append(collection)
      }
    }
    return result
  }
  
  private func generateTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.allowsSelection = true
    tableView.isUserInteractionEnabled = true
    tableView.showsVerticalScrollIndicator = false
    view.addSubview(tableView)
    tableView.snp.makeConstraints { maker in
      maker.top.equalTo(searchBar.snp.bottom)
      maker.left.right.bottom.equalToSuperview()
    }
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if searchCollections.count > 0 {
      return searchCollections.count
    } else { return DataModel.collections.count }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var collections = [Collection]()
    
    if searchCollections.count > 0 {
      collections = searchCollections
    } else {
      collections = DataModel.collections
    }
    
    let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
    
    cell.textLabel?.text = collections[indexPath.row].name
    
    cell.detailTextLabel?.text = "\(collections[indexPath.row].collection.count) Item"
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    var collections = [Collection]()
    
    if searchCollections.count > 0 {
      collections = searchCollections
    } else {
      collections = DataModel.collections
    }
    
    let selectedCollection = collections[indexPath.row]
    let collectionVC = CollectionViewController(collection: selectedCollection)
    show(collectionVC, sender: true)
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      if searchCollections.count > 0 {
        DataModel.removeCollection(searchCollections[indexPath.row])
        searchCollections.remove(at: indexPath.row)
        if searchCollections.isEmpty {
          tableView.reloadData()
          searchBar.text = ""
        } else {
          tableView.deleteRows(at: [indexPath], with: .fade)
        }
      } else {
        DataModel.collections.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
      }
    }
  }
  
}
