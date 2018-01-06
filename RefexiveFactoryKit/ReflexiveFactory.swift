//
//  ReflexiveFactory.swift
//  RefexiveFactoryKit
//
//  Created by Vincent on 06/01/2018.
//  Copyright © 2018 Vincent. All rights reserved.
//

import Foundation
import UIKit
import ObjectiveC

public struct ReflexiveFactory {
    
    public static func retrieveAllViewControllers(in bundle: Bundle) -> [UIViewController.Type] {
        let bundlePath = bundle.executablePath
        
        var count: UInt32 = 0
        var classes: UnsafeMutablePointer<UnsafePointer<Int8>>!
        
        var viewControllers = [String]()
        
        if let bundlePath = bundlePath {
            
            classes = objc_copyClassNamesForImage(bundlePath, &count)
            
            for index in 0..<count {
                let className = classes[Int(index)]
                
                if let name = NSString.init(utf8String:className) as String?,
                    name.hasSuffix("Controller")
                {
                    viewControllers.append(name)
                }
            }
        }
        
        return viewControllers
            .sorted()
            .flatMap { ReflexiveFactory.stringClassFromString($0) as? UIViewController.Type }
    }
    
    private static func stringClassFromString(_ className: String) -> AnyClass? {
        
        let namespace = (Bundle.main.infoDictionary!["CFBundleExecutable"] as! String)
        
        let cls: AnyClass? = NSClassFromString("\(namespace).\(className)") ?? NSClassFromString(className)
        
        return cls
    }
}
