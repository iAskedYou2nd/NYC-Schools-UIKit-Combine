//
//  School.swift
//  NYCSchoolsWithCombine
//
//  Created by iAskedYou2nd on 12/29/22.
//

import Foundation

struct School: Decodable {
    
    let dbn: String
    let schoolName: String
    let overviewParagraph: String
    let location: String
    let phoneNumber: String
    let schoolEmail: String?
    let website: String
    let primaryAddressLine1: String
    let city: String
    let zip: String
    let stateCode: String
    let latitude: String?
    let longitude: String?
    
}
