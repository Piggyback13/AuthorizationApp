//
//  AppCoordinator.swift
//  AuthorizationApp
//
//  Created by piggyback13 on 25.02.2023.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var isLoggedIn: Bool = false
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        if isLoggedIn == true {
            showProfileVC(delegate: LoginViewController(), login: User.logins[0].login ?? "")
        } else {
            showLoginVC()
        }
    }
    
    func showLoginVC() {
        let vc = LoginViewController()
        vc.coordinator = self
        vc.viewModel = LoginViewModel()
        vc.viewModel?.isLoggedIn = isLoggedIn
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showProfileVC(delegate: LoginViewController, login: String) {
        let vc = ProfileViewController()
        vc.coordinator = self
        vc.delegate = delegate
        vc.viewModel = ProfileViewModel()
        vc.viewModel?.login = login
        navigationController.pushViewController(vc, animated: true)
    }
    
    func exitToLoginVC() {
        let vc = LoginViewController()
        vc.coordinator = self
        vc.viewModel = LoginViewModel()
        vc.viewModel?.isLoggedIn = isLoggedIn
        navigationController.popViewController(animated: true)
    }
    
}
