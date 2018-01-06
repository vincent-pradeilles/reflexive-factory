//
//  SecondViewController.swift
//  ReflexiveFactory
//
//  Created by Vincent on 06/01/2018.
//  Copyright © 2018 Vincent. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    let descriptionLabel = UILabel()
    
    override func loadView() {
        super.loadView()
        
        descriptionLabel.text = "This is the second view controller."
        descriptionLabel.textColor = .black
        descriptionLabel.textAlignment = .center
        view.addSubview(descriptionLabel)
        
        view.backgroundColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        descriptionLabel.frame = view.bounds
    }
}

