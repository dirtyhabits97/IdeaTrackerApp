//
//  LoginViewController.swift
//  AdminIdeaTracker
//
//  Created by DIGITAL008 on 10/11/20.
//

import Foundation
import UIKit
import Utils

class LoginViewController: BaseViewController {
    
    // MARK: - Properties
    
    var viewModel: LoginViewModel?
    
    // MARK: - UI elements
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let usernameTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Username"
        textfield.autocapitalizationType = .none
        return textfield
    }()
    
    private let passwordTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Password"
        textfield.isSecureTextEntry = true
        textfield.autocapitalizationType = .none
        return textfield
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func setupView() {
        super.setupView()
        // set up the button
        loginButton.addTarget(
            self,
            action: #selector(didPressLoginButton),
            for: .touchUpInside
        )
        // set up the view hierarchy
        view.addSubview(stackView)
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(loginButton)
        // set up the constraints
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    override func setupBindings() {
        viewModel?.onFailure = { [weak self] (error) in
            guard let self = self else { return }
            let msg = "Failed to log user in: \(error)"
            print(msg)
            self.errorHandler?.handleError(msg)
        }
        viewModel?.onSuccess = {
            print("Login success")
        }
    }
    
    // MARK: - Interaction handling
    
    @objc func didPressLoginButton() {
        guard
            let username = usernameTextField.text,
            let password = passwordTextField.text
        else {
            return
        }
        viewModel?.logUserIn(username, password: password)
    }
    
}
