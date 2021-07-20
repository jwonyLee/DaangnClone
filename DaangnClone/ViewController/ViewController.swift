//
//  ViewController.swift
//  DaangnClone
//
//  Created by 이지원 on 2021/07/20.
//

import UIKit

class ViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabBar()
    }
}

// MARK: - Private
extension ViewController {
    private func configureTabBar() {
        let homeViewController: UINavigationController = UINavigationController(rootViewController: HomeViewController())
        homeViewController.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        let townViewController: BaseViewController = BaseViewController()
        townViewController.tabBarItem = UITabBarItem(title: "동네생활", image: UIImage(systemName: "doc.plaintext"), selectedImage: UIImage(systemName: "doc.plaintext.fill"))
        let nearViewController: BaseViewController = BaseViewController()
        nearViewController.tabBarItem = UITabBarItem(title: "내 근처", image: UIImage(systemName: "location"), selectedImage: UIImage(systemName: "location.fill"))
        let chatViewController: BaseViewController = BaseViewController()
        chatViewController.tabBarItem = UITabBarItem(title: "채팅", image: UIImage(systemName: "bubble.left.and.bubble.right"), selectedImage: UIImage(systemName: "bubble.left.and.bubble.right.fill"))
        let profileViewController: BaseViewController = BaseViewController()
        profileViewController.tabBarItem = UITabBarItem(title: "나의 당근", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        self.tabBar.tintColor = .systemOrange
        self.viewControllers = [homeViewController, townViewController, nearViewController, chatViewController, profileViewController]
    }
}
