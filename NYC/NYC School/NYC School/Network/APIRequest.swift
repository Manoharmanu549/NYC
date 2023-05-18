//
//  APIRequest.swift
//  NYC School
//
//  Created by Manohar on 5/14/23.
//

import Foundation

// MARK: - APIRequest

class APIRequest<Resource: APIResource> {
    let resource: Resource
    let session: URLSession
    
    //set session for testing
    init(resource: Resource, session: URLSession = URLSession.shared) {
        self.resource = resource
        self.session = session
    }
}

// MARK: - Extension

extension APIRequest: NetworkRequest {
    
    func decode(_ data: Data) -> Resource.ModelType? {
        do {
            let modelType = try JSONDecoder().decode(Resource.ModelType.self, from: data)
            // success
            return modelType
        } catch {
            return nil
        }
    }
    
    func execute(withCompletion completion: @escaping (Resource.ModelType?, Error?) -> Void) {
        guard let request = resource.request else {
            DispatchQueue.main.async { completion(nil,ErrorResult.custom(string: Errors.InvalidUrl.rawValue)) }
            return
        }
        load(request, withCompletion: completion)
    }
}

