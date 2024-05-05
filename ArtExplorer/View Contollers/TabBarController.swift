//
//  TabBarController.swift
//  ArtExplorer
//
//  Created by anikin02 on 01.04.2024.
//

import UIKit

class TabBarController: UITabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    generateTabBar()
    changeColor(tabBarController: self, colorBG: .white, colorTint: .systemPink)
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
        title: "Home",
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
  
  func changeColor(tabBarController: UITabBarController?, colorBG: UIColor, colorTint: UIColor) {
    let appearance = UITabBarAppearance()
    appearance.backgroundColor = colorBG
    appearance.selectionIndicatorTintColor = colorTint
    appearance.shadowColor = nil
    tabBarController?.tabBar.standardAppearance = appearance
        
    if #available(iOS 15.0, *) {
      tabBarController?.tabBar.scrollEdgeAppearance = appearance
    }
  }
}
