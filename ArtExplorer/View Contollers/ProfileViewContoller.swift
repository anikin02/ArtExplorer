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
  private var profile = ProfileInfo()
  private let searchBar = UISearchBar()
  private let addCollectionButton = UIButton()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    // TEST DATA
    let collection1 = Collection(collection: [Art(name: "Моно Лиза", author: "Леонардо Да Винчи", description: "Описание", genre: "Какой-то", date: "1503", image: "testImage1")], name: "Любимое Ван Гог")
    let collection2 = Collection(collection: [Art(name: "Звездная ночь", author: "Ван Гог", description: "Описание", genre: "Какой-то", date: "Июнь 1889 – Июль 1889", image: "testImage2")], name: "Любимое Леонадро Да Винчи")
    profile = ProfileInfo(collections: [
      collection1,
      collection2,
      Collection(collection: [], name: "Портреты"),
      Collection(collection: [], name: "Кубизм"),
      Collection(collection: [], name: "Пейзажи"),
      Collection(collection: [], name: "Современное")
    ])
    // TEST DATA
    
    generateSafeArea()
    generateSearchBar()
    generateTableView()
    generateAddCollectionButton()
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
      maker.bottom.equalTo(tableView.snp.bottom).offset(-80)
      maker.right.equalToSuperview().offset(-15)
      maker.width.equalTo(50)
      maker.height.equalTo(50)
    }
  }
  
  @objc func addCollectionButtonTapped() {
    let addCollectionViewController = AddCollectionViewController()
    addCollectionViewController.onSave = { name in
      self.profile.collections.append(Collection(collection: [], name: name))
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
    return profile.collections.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        
    cell.textLabel?.text = profile.collections[indexPath.row].name
    
    cell.detailTextLabel?.text = "\(profile.collections[indexPath.row].collection.count) Item"
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("HELLo")
      let selectedCollection = profile.collections[indexPath.row]
      let collectionVC = CollectionViewController(collection: selectedCollection)
    show(collectionVC, sender: true)
  }

}
