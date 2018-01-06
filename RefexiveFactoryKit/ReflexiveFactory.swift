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
        guard let bundlePath = bundle.executablePath else { return [] }
        
        var size: UInt32 = 0
        var classes: UnsafeMutablePointer<UnsafePointer<Int8>>!
        
        var viewControllers = [String]()
        
        classes = objc_copyClassNamesForImage(bundlePath, &size)
            
        for index in 0..<size {
            let className = classes[Int(index)]
                
            if let name = NSString.init(utf8String:className) as String?,
                name.hasSuffix("Controller")
            {
                viewControllers.append(name)
            }
        }
        
        return viewControllers
            .sorted()
            .flatMap { ReflexiveFactory.stringClassFromString($0, in: bundle) as? UIViewController.Type }
    }
    
    private static func stringClassFromString(_ className: String, in bundle: Bundle) -> AnyClass? {
        
        let namespace = (bundle.infoDictionary!["CFBundleExecutable"] as! String)
        
        let cls: AnyClass? = NSClassFromString("\(namespace).\(className)") ?? NSClassFromString(className)
        
        return cls
    }
}
