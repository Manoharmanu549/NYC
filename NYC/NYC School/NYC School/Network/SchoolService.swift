//
//  SchoolService.swift
//  NYC School
//
//  Created by Manohar on 5/14/23.
//

import Foundation

protocol SchoolsServiceProtocol : AnyObject {
    func getSchools(completion: @escaping ([SchoolDetailsModel]?, Error?) -> ())
}

class SchoolService: SchoolsServiceProtocol {
    private var request: APIRequest<SchoolListResource>?
    
    // MARK: - Protocol Function
    func getSchools(completion: @escaping ([SchoolDetailsModel]?, Error?) -> ()) {
        let resource = SchoolListResource()
        let request = APIRequest(resource: resource)
        self.request =  request
        request.execute(withCompletion: completion)
    }
}

