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
  private var eventsCollection = [Event]()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    // TEST DATA
    for i in 0...15 {
      eventsCollection.append(Event(name: "Название \(i)", location: "Локация \(i)", date: "Весна 2024", description: "очень интересно"))
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
    return eventsCollection.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return EventsViewControllerCell(event: eventsCollection[indexPath.row])
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 64
  }

}
