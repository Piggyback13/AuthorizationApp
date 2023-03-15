//
//  Coordinator.swift
//  AuthorizationApp
//
//  Created by piggyback13 on 25.02.2023.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
