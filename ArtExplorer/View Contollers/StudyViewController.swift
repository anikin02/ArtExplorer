//
//  StudyViewController.swift
//  ArtExplorer
//
//  Created by anikin02 on 01.04.2024.
//

import UIKit

class StudyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  private var tableView = UITableView()

  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }

}
