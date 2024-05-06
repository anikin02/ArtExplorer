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
    return DataModel.collections.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        
    cell.textLabel?.text = DataModel.collections[indexPath.row].name
    
    cell.detailTextLabel?.text = "\(DataModel.collections[indexPath.row].collection.count) Item"
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let selectedCollection = DataModel.collections[indexPath.row]
      let collectionVC = CollectionViewController(collection: selectedCollection)
    show(collectionVC, sender: true)
  }

}
