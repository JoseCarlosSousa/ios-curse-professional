//
//  LogoutViewController.swift
//  Bankey
//
//  Created by Jose Sousa on 09/01/2023.
//

import UIKit

class LogoutViewController: UIViewController {
    
    let stackView = UIStackView()
    let label = UILabel()
    let logoutButton = UIButton()
    
    weak var delegate: LogoutDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
}

extension LogoutViewController {
    
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.configuration = .filled()
        logoutButton.setTitle("Logout", for: [])
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .primaryActionTriggered)
    }
    
    func layout() {
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(logoutButton)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func logoutTapped(sender: UIButton) {
        delegate?.didLogout()
    }
}
