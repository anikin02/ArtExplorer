//
//  AddInCollectionViewController.swift
//  ArtExplorer
//
//  Created by Данил Аникин on 06.05.2024.
//

import UIKit


class AddInCollectionViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate {
  private var tableView = UITableView()
  private let addCollectionButton = UIButton()
  private let safeAreaView = UIView()
  var art: Art?

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    generateSafeArea()
    generateTableView()
    generateAddCollectionButton()
  }
  
  private func generateSafeArea() {
    safeAreaView.backgroundColor = .white

    view.addSubview(safeAreaView)
    safeAreaView.snp.makeConstraints { maker in
      maker.top.equalTo(view.snp.top)
      maker.left.right.equalToSuperview()
      maker.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
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
      maker.top.equalTo(safeAreaView.snp.bottom)
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
    if let art = self.art {
      DataModel.collections[indexPath.row].collection.append(art)
    }
    dismiss(animated: true)
  }
}
