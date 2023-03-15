//
//  Dynamic.swift
//  AuthorizationApp
//
//  Created by piggyback13 on 25.02.2023.
//

import Foundation

class Dynamic<T> {
    
    typealias Listener = (T) -> Void
    private var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    init(_ v: T) {
        value = v
    }
    
}
