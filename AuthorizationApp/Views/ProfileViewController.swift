//
//  ProfileViewController.swift
//  AuthorizationApp
//
//  Created by piggyback13 on 25.02.2023.
//

import UIKit
import SnapKit

final class ProfileViewController: UIViewController {
    
    // MARK: - External variables
    weak var coordinator: AppCoordinator?
    weak var delegate: LoginViewControllerDelegate?
    var viewModel: ProfileViewModel?
    
    // MARK: - Internal variables
    private lazy var nameLabel: UILabel = {
        var label = UILabel()
        label.font.withSize(20)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var exitButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setTitle("Выйти из кабинета", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(exitButtonPressed), for: .touchUpInside)
        return button
    }()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        [nameLabel, exitButton].forEach { subview in
            view.addSubview(subview)
        }
        
        setupConstraints()
        nameLabel.text = viewModel?.login
    }

}

// MARK: - Private methods
private extension ProfileViewController {
    
    private func setupConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(50)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(exitButton.snp.top).offset(-20)
        }
        
        exitButton.snp.makeConstraints { make in
            make.centerY.centerX.equalTo(self.view)
            make.width.greaterThanOrEqualTo(200)
            make.height.equalTo(50)
        }
    }
    
}

// MARK: - Actions
extension ProfileViewController {
    
    @objc func exitButtonPressed(sender: UIButton) {
        coordinator?.isLoggedIn = viewModel!.isLoggedIn
        coordinator?.exitToLoginVC()
        delegate?.clearLoginTF()
        delegate?.clearPasswordTF()
    }
    
}
