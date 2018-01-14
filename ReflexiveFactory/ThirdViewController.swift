//
//  ThirdViewController.swift
//  ReflexiveFactory
//
//  Created by Vincent on 06/01/2018.
//  Copyright © 2018 Vincent. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    enum UseCase: String {
        case login
        case logout
    }
    
    var contentView: UIView!
    
    var currentUseCase: UseCase = .login
    
    override func loadView() {
        super.loadView()
        
        switch currentUseCase {
        case .login:
            let inputField = UITextField()
            inputField.placeholder = "Enter your login"
            
            contentView = inputField
        case .logout:
            let button = UIButton(type: .system)
            button.setTitle("Logout", for: .normal)
            
            contentView = button
        }

        view.addSubview(contentView)

        view.backgroundColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        contentView.frame = view.bounds
    }
}

extension ThirdViewController: UseCaseInstantiable {
    static var useCases: [String] {
        return [UseCase.login, UseCase.logout].map { $0.rawValue }
    }
    
    static func instantiate(for useCase: String) -> Self {
        let viewController = self.init()
        
        if let useCase = UseCase(rawValue: useCase) {
            viewController.currentUseCase = useCase
        }
        
        return viewController
    }
}
