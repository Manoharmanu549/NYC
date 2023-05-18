//
//  SchoolDetailViewModel.swift
//  NYC School
//
//  Created by Manohar on 5/14/23.
//

import Foundation

protocol SchoolDetailViewModelProtocol {
    var schoolDetails: SchoolDetailsModel { get }
}

class SchoolDetailViewModel: SchoolDetailViewModelProtocol {
    
    // MARK: - Protocol Properties
    let schoolDetails: SchoolDetailsModel
    
    // MARK: - initializer
    init(schoolDetails: SchoolDetailsModel) {
        self.schoolDetails = schoolDetails
    }
}
