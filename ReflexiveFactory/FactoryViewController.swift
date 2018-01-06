//
//  FactoryViewController.swift
//  ReflexiveFactory
//
//  Created by Vincent on 06/01/2018.
//  Copyright © 2018 Vincent. All rights reserved.
//

import UIKit
import RefexiveFactoryKit

class FactoryViewController: UIViewController {

    let viewControllerTypes = ReflexiveFactory.retrieveAllViewControllers(in: Bundle.main)
        .filter { !String(describing: $0).contains("FactoryViewController") }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.indexPathForSelectedRow.map { tableView.deselectRow(at: $0, animated: true) }
    }
}

extension FactoryViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewControllerTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FactoryViewControllerCell")!
        
        cell.textLabel?.text = String(describing: viewControllerTypes[indexPath.row])
        
        return cell
    }
}

extension FactoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newControllerType = viewControllerTypes[indexPath.row]
        
        if let newControllerType = newControllerType as? (UIViewController & UseCaseInstantiable).Type {
            let alert = UIAlertController(title: "Choose a use case", message: nil, preferredStyle: .actionSheet)
            let instantiation = { (useCase: String) in
                alert.dismiss(animated: true, completion: nil)
                self.show(newControllerType.instantiate(for: useCase), sender: self)
            }
            
            alert.addAction(UIAlertAction(title: "Login", style: .default, handler: { (action) in
                instantiation(action.title!.lowercased())
            }))
            
            alert.addAction(UIAlertAction(title: "Logout", style: .default, handler: { (action) in
                instantiation(action.title!.lowercased())
            }))
            
            present(alert, animated: true, completion: nil)
        } else {
            show(newControllerType.init(nibName: nil, bundle: nil), sender: self)
        }
    }
}
