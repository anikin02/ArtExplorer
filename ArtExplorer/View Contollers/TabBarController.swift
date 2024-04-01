//
//  TabBarContoller.swift
//  ArtExplorer
//
//  Created by anikin02 on 01.04.2024.
//

import UIKit

class TabBarContoller: UITabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    generateTabBar()
  }
  
  private func generateTabBar() {
    viewControllers = [
      generateVC(
        viewContoller: StudyViewController(),
        title: "Study",
        image: UIImage(systemName: "book.fill")
      ),
      generateVC(
        viewContoller: EventsViewConroller(),
        title: "Events",
        image: UIImage(systemName: "calendar")
      ),
      generateVC(
        viewContoller: RecommendationsViewController(),
        title: "Recommendations",
        image: UIImage(systemName: "house.fill")
      ),
      generateVC(
        viewContoller: ProfileViewContoller(),
        title: "Profile",
        image: UIImage(systemName: "person.crop.circle")
      )
    ]
  }
  
  private func generateVC(viewContoller: UIViewController, title: String, image: UIImage?) -> UIViewController {
    viewContoller.tabBarItem.title = title
    viewContoller.tabBarItem.image = image
    
    return viewContoller
  }
}
