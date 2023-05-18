//
//  ListOfSchoolModel.swift
//  NYC School
//
//  Created by Manohar on 5/14/23.
//

import Foundation

protocol SchoolListViewModelProtocol {
    var schoolLists: Dynamic<[SchoolDetailsModel]?> { get }
    var error: Dynamic<String?> { get }
    func getSchoolList()
}

class ListOfSchoolModel: SchoolListViewModelProtocol {
    
    // MARK: - Protocol Properties
    
    var schoolLists: Dynamic<[SchoolDetailsModel]?> = Dynamic(nil)
    var error: Dynamic<String?> = Dynamic(nil)
    
    // MARK: - Properties
    
    private var schoolsService: SchoolsServiceProtocol
    
    // MARK: - initializer
    
    init(withService service: SchoolsServiceProtocol) {
        // perform initialization
        self.schoolsService = service
    }
    
    // MARK: - Protocol function
    
    func getSchoolList() {
        
        /// get school from server
        schoolsService.getSchools() { [weak self] (data, err) in
            
            /// Bind data
            if let _data = data {
                self?.schoolLists.value = _data
            } else {
                self?.error.value = err?.localizedDescription ?? Errors.NoData.rawValue
            }
        }
    }
}

