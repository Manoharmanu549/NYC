//
//  APIResource.swift
//  NYC School
//
//  Created by Manohar on 5/14/23.
//

import Foundation

// MARK: - Url
enum UrlEnum {
    // Host
    static let baseURL = "https://data.cityofnewyork.us"
    // path
    static let satScore = "/resource/f9bf-2cp4.json"
}

// MARK: - APIResource

protocol APIResource {
    associatedtype ModelType: Decodable
    var request: URLRequest? { get }
}

// MARK: - SchoolListResource

struct SchoolListResource: APIResource {
    typealias ModelType = [SchoolDetailsModel]
    var queryValue: String?
    let methodPath: String = UrlEnum.satScore
    
    var request: URLRequest? {
        var components = URLComponents(string:UrlEnum.baseURL)!
        components.path = methodPath
        //pass if needed
        components.query = queryValue
        guard let url = components.url else { return nil }
        let request = URLRequest(url: url)
        return request
    }
}

