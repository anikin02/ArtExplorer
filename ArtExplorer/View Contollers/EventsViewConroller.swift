//
//  EventsViewConroller.swift
//  ArtExplorer
//
//  Created by anikin02 on 01.04.2024.
//

import UIKit

class EventsViewConroller: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
  
  private var tableView = UITableView()
  private let searchBar = UISearchBar()
  private var allEventsCollection = [Event]()
  private var searchEventsCollection = [Event]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    DispatchQueue.main.async {
      self.allEventsCollection = APIManager.shared.getEvents()
      self.searchBar.scopeButtonTitles = self.getScopeBarTitles()
      self.tableView.reloadData()
    }
    
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
    searchBar.showsScopeBar = false
    view.addSubview(searchBar)
    
    searchBar.snp.makeConstraints { maker in
      maker.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      maker.left.right.equalToSuperview()
    }
  }
  
  private func getScopeBarTitles() -> [String] {
    var result: Set<String> = ["All"]
    
    for event in allEventsCollection {
      result.insert(event.location)
    }
    
    return Array(result)
  }
  
  func getSearchEventsCollection(key: String) -> [Event] {
    var result = [Event]()
    for event in allEventsCollection {
      if event.name.lowercased().contains(key.lowercased()) ||
          event.location.lowercased().contains(key.lowercased()) {
        result.append(event)
      }
    }
    return result
  }
  
  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    if let searchText = searchBar.text {
      searchEventsCollection = getSearchEventsCollection(key: searchText)
    }
    if searchEventsCollection.count > 0 {
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
    searchEventsCollection = []
    searchBar.resignFirstResponder()
    tableView.reloadData()
    searchBar.setShowsCancelButton(false, animated: true)
  }
  
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    searchBar.showsScopeBar = true
    searchBar.sizeToFit()
  }
  
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    searchBar.showsScopeBar = false
    searchBar.sizeToFit()
  }
  
  private func generateTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.showsVerticalScrollIndicator = false
    view.addSubview(tableView)
    tableView.snp.makeConstraints { maker in
      maker.top.equalTo(searchBar.snp.bottom)
      maker.left.right.bottom.equalToSuperview()
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if searchEventsCollection.count > 0 {
      return searchEventsCollection.count
    } else { return allEventsCollection.count }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if searchEventsCollection.count > 0 {
      return EventsViewControllerCell(event: searchEventsCollection[indexPath.row])
    } else { return EventsViewControllerCell(event: allEventsCollection[indexPath.row]) }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    //    if searchCollections.count > 0 {
    //      collections = searchCollections
    //    } else {
    //      collections = DataModel.collections
    //    }
    
    let selectedEvent = allEventsCollection[indexPath.row]
    let collectionVC = DetailEventViewController(event: selectedEvent)
    show(collectionVC, sender: true)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 64
  }
  
}
