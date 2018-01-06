//
//  ThirdViewController.swift
//  ReflexiveFactory
//
//  Created by Vincent on 06/01/2018.
//  Copyright © 2018 Vincent. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    let descriptionLabel = UILabel()
    
    var data: String? = nil
    
    override func loadView() {
        super.loadView()
        
        descriptionLabel.text = """
        This is the third view controller.
        The initial data is: \(data ?? "")
        """
        descriptionLabel.textColor = .black
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 2
        view.addSubview(descriptionLabel)
        
        view.backgroundColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        descriptionLabel.frame = view.bounds
    }
}

extension ThirdViewController: InitialDataInstantiable {
    static func instantiate(with initialData: Any) -> Self {
        let viewController = self.init()
        
        viewController.data = initialData as? String
        
        return viewController
    }
}
