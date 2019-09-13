//
//  ViewConfiguration.swift
//  Store
//
//  Created by 양혜리 on 13/09/2019.
//  Copyright © 2019 hryang. All rights reserved.
//

import Foundation

protocol ViewConfiguration {
    associatedtype ViewModelType
    var viewModel: ViewModelType { get set }
    func configure(by viewModel: ViewModelType, parameter: [AnyHashable: String]?)
}
