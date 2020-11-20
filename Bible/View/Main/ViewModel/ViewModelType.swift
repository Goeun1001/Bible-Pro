//
//  viewModelType.swift
//  Bible
//
//  Created by jge on 2020/08/11.
//  Copyright © 2020 jge. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype InputType

    func apply(_ input: InputType)
}
