//
//  AppCoordinator.swift
//  iOSTrainee PostApp
//
//  Created by macbook on 15.11.2023.
//

import UIKit

protocol AppCoordinatorProtocol: Coordinator {
    var windowScene: UIWindow? { get }
}

class AppCoordinator: AppCoordinatorProtocol {
    var windowScene: UIWindow?
    var childCoordinator: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    init(windowScene: UIWindow?) {
        self.windowScene = windowScene
        self.navigationController = UINavigationController()
    }
    
    func start() {
        windowScene?.rootViewController = navigationController
        windowScene?.makeKeyAndVisible()
        startMainCoordinator()
    }
    
    func finish() {
        //
    }
    
    private func startMainCoordinator() {
        let coordinator = MainCoordinator(navigationController: navigationController)
        childCoordinator.append(coordinator)
        coordinator.start()
    }
    
}
