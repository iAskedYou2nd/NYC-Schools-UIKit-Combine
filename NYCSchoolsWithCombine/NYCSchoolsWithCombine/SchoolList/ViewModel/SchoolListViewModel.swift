//
//  SchoolListViewModel.swift
//  NYCSchoolsWithCombine
//
//  Created by iAskedYou2nd on 12/29/22.
//

import Foundation
import Combine

class SchoolListViewModel {
    
    private var subs = Set<AnyCancellable>()
    
    private let network: Network
    @Published var schoolList: [School] = []
    private var schoolDetailViewModels: [Int: SchoolDetailViewModel] = [:]
    
    init(network: Network = NetworkManager()) {
        self.network = network
    }
    
    var count: Int {
        return self.schoolList.count
    }
    
    func requestSchools() {
        self.network.requestModel(request: Environment.schools.request)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] (schoolList: [School]) in
                print("Schools Received")
                self?.schoolList = schoolList
            }.store(in: &self.subs)
    }
    
    func schoolDetailViewModel(for index: Int) -> SchoolDetailViewModel? {
        guard index < self.count else { return nil }
        if let existingDetailViewModel = self.schoolDetailViewModels[index] {
            return existingDetailViewModel
        }
        let detailViewModel = SchoolDetailViewModel(network: self.network, school: self.schoolList[index])
        self.schoolDetailViewModels[index] = detailViewModel
        
        return detailViewModel
    }
    
}
