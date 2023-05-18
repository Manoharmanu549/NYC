//
//  Constants.swift
//  NYC School
//
//  Created by Manohar on 5/14/23.
//

import Foundation

// MARK: - Error
enum Errors: String {
    case NOInternetConnection = "NO Internet Connection , Try Again"
    case NoData = "Data Not Available"
    case InvalidUrl = "Url Not Valid"
}

enum ErrorResult: Error {
    case custom(string: String)
}
