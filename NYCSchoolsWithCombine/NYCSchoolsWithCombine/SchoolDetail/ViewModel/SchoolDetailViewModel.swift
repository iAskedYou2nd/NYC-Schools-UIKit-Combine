//
//  SchoolDetailViewModel.swift
//  NYCSchoolsWithCombine
//
//  Created by iAskedYou2nd on 12/29/22.
//

import Foundation
import Combine


class SchoolDetailViewModel {
    
    private let network: Network
    private let school: School
    private var subs = Set<AnyCancellable>()
    
    @Published var schoolSATScores: SchoolSATScores?

    init(network: Network, school: School) {
        self.network = network
        self.school = school
    }
    
    func requestSATScores() {
        self.network.requestModel(request: Environment.schoolDetails(self.school.dbn).request)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print(completion)
            } receiveValue: { (schoolSAT: [SchoolSATScores]) in
                self.schoolSATScores = schoolSAT.first
            }.store(in: &self.subs)
    }
    
    var schoolName: String {
        return self.school.schoolName
    }
    
    // Replaces bug from data in API where "&nbsp;" are being sent as "Â" instead. Removes all occurences as there should not be a space to begin with. Band-aid fix as this is a backend issue.
    var schoolOverview: String {
        return self.school.overviewParagraph.replacingOccurrences(of: "Â", with: "")
    }
    
    var zipcode: String {
        return self.school.zip
    }
    
    var address: String {
        return "\(self.school.primaryAddressLine1), \(self.school.city), \(self.school.stateCode), \(self.school.zip)"
    }
    
    var readingScore: String {
        return "Reading: \(self.schoolSATScores?.readingScore ?? "N/A")"
    }
    
    var mathScore: String {
        return "Math: \(self.schoolSATScores?.mathScore ?? "N/A")"
    }
    
    var writingScore: String {
        return "Writing: \(self.schoolSATScores?.writingScore ?? "N/A")"
    }
    
    var latitude: String? {
        return self.school.latitude
    }
    
    var longitude: String? {
        return self.school.longitude
    }
    
    var webAddress: URL? {
        var components = URLComponents(string: self.school.website)
        components?.scheme = "https"
        return components?.url
    }
    
}
