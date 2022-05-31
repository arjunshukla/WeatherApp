//
//  MainCoordinator.swift
//  Weather
//
//  Created by Arjun Shukla on 5/30/22.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = ListViewController.instantiate()
        navigationController.pushViewController(vc, animated: false)
    }
}
