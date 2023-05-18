//
//  NetworkRequest.swift
//  NYC School
//
//  Created by Manohar on 5/14/23.
//

import Foundation
import UIKit

// MARK: - NetworkRequest

protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    func decode(_ data: Data) -> ModelType?
    func execute(withCompletion completion: @escaping (ModelType?,Error?) -> Void)
    var session: URLSession { get }
}

extension NetworkRequest {
    func load(_ request: URLRequest, withCompletion completion: @escaping (ModelType?,Error?) -> Void) {
        let task = session.dataTask(with: request) { [weak self] (data, _ , err) -> Void in
            guard let data = data, let value = self?.decode(data) else {
                DispatchQueue.main.async { completion(nil,err) }
                return
            }
            
            DispatchQueue.main.async { completion(value,nil) }
        }
        task.resume()
    }
}

