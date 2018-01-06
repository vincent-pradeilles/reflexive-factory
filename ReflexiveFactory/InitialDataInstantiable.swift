//
//  InitialDataInstantiable.swift
//  ReflexiveFactory
//
//  Created by Vincent on 06/01/2018.
//  Copyright © 2018 Vincent. All rights reserved.
//

import Foundation

protocol InitialDataInstantiable {    
    static func instantiate(with initialData: Any) -> Self
}
