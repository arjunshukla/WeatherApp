//
//  Coordinator.swift
//  Weather
//
//  Created by Arjun Shukla on 5/30/22.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
