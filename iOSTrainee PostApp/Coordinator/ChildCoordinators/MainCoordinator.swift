//
//  MainCoordinator.swift
//  iOSTrainee PostApp
//
//  Created by macbook on 15.11.2023.
//

import UIKit

final class MainCoordinator: Coordinator {
    var childCoordinator: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func start() {
        let viewController = MainViewController()
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func finish() {
        //
    }
    
    
    
}
