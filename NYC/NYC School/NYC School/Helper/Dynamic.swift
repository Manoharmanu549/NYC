//
//  Dynamic.swift
//  NYC School
//
//  Created by Manohar on 5/14/23.
//

import Foundation

class Dynamic<T> {
    typealias Observer = (T) -> Void
    var observer: Observer?
    
    func bind(_ observer: Observer?) {
        self.observer = observer
    }
    
    func bindAndTigger(_ observer: Observer?) {
        self.observer = observer
        observer?(value)
    }
    
    var value: T {
        didSet {
            observer?(value)
        }
    }
    
    init(_ v: T) {
        value = v
    }
}
