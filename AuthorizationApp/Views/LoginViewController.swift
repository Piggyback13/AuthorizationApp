//
//  ViewController.swift
//  AuthorizationApp
//
//  Created by piggyback13 on 25.02.2023.
//

import UIKit
import SnapKit

protocol LoginViewControllerDelegate: AnyObject {
    func clearLoginTF()
    func clearPasswordTF()
}

final class LoginViewController: UIViewController {
    
    // MARK: - External variables
    var coordinator: AppCoordinator?
    var viewModel: LoginViewModel?
    
    // MARK: - Internal variables
    private lazy var loginLabel: UILabel = {
        var label = UILabel()
        label.text = "Логин"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    private lazy var loginTF: UITextField = {
        var textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Введите логин..."
        textField.textColor = .white
        textField.autocapitalizationType = .none
        textField.backgroundColor = .lightGray
        return textField
    }()
    
    private lazy var passwordLabel: UILabel = {
        var label = UILabel()
        label.text = "Пароль"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    private lazy var passwordTF: UITextField = {
        var textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Введите пароль..."
        textField.textColor = .white
        textField.autocapitalizationType = .none
        textField.backgroundColor = .lightGray
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var captchaLabel: UILabel = {
        var label = UILabel()
        label.text = "Капча"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    private lazy var captchaImgView: UIImageView = {
        var imageView = UIImageView()
        return imageView
    }()
    
    private lazy var captchaTF: UITextField = {
        var textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Введите капчу..."
        textField.textColor = .white
        textField.autocapitalizationType = .allCharacters
        textField.backgroundColor = .lightGray
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var statusLabel: UILabel = {
        var label = UILabel()
        label.font.withSize(20)
        label.textColor = .red
        label.numberOfLines = 0
        return label
    }()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        view.backgroundColor = .white
        
        [loginLabel, passwordLabel, captchaLabel, loginTF, passwordTF, captchaTF, loginButton, statusLabel].forEach { subview in
            view.addSubview(subview)
        }
        
        setupConstraints()
        bindViewModel()
    }

}

// MARK: - Private methods
private extension LoginViewController {
    
    private func setupConstraints() {
        loginLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(10)
        }
        
        loginTF.snp.makeConstraints { make in
            make.top.equalTo(loginLabel.snp.bottom).offset(5)
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(10)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(loginTF.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(10)
        }
        
        passwordTF.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(5)
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(10)
        }
        
        captchaLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTF.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(10)
        }
        
        captchaTF.snp.makeConstraints { make in
            make.top.equalTo(captchaLabel.snp.bottom).offset(5)
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(10)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(captchaTF.snp.bottom).offset(50)
            make.centerX.equalTo(self.view)
            make.width.equalTo(120)
            make.height.equalTo(50)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(5)
            make.centerX.equalTo(self.view)
            make.bottom.lessThanOrEqualTo(self.view).inset(20)
        }
    }
    
    private func bindViewModel() {
        viewModel?.status.bind({ status in
            DispatchQueue.main.async {
                self.statusLabel.text = status
            }
        })
    }
    
}

// MARK: - Actions
extension LoginViewController {
    
    @objc func dissmissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func loginButtonPressed(sender: UIButton) {
        viewModel?.logIn(login: loginTF.text ?? "", password: passwordTF.text ?? "")
        
        if viewModel?.isLoggedIn == true {
            coordinator?.isLoggedIn = viewModel!.isLoggedIn
            coordinator?.showProfileVC(delegate: self, login: loginTF.text ?? "")
        }
    }
    
}

// MARK: - LoginViewController Delegate
extension LoginViewController: LoginViewControllerDelegate {
    
    func clearLoginTF() {
        loginTF.text?.removeAll()
    }
    
    func clearPasswordTF() {
        passwordTF.text?.removeAll()
    }
    
}
