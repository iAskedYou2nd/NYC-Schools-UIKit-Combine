//
//  MainCoordinator.swift
//  NYCSchoolsWithCombine
//
//  Created by iAskedYou2nd on 12/29/22.
//

import UIKit
import SafariServices

//protocol Coordinator {
//    var navigationController: UINavigationController { get }
//    func launch()
////    func pushDetail(detailViewModel: )
//}

class SchoolCoordinator {
    
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func launch() {
        let rootViewModel = SchoolListViewModel()
        let rootVC = SchoolListViewController(schoolListViewModel: rootViewModel)
        rootVC.coordinator = self
        self.navigationController.pushViewController(rootVC, animated: false)
    }
    
    func pushSchoolDetail(detailViewModel: SchoolDetailViewModel?) {
        guard let detailViewModel = detailViewModel else { return }
        let schoolDetailVC = SchoolDetailViewController(viewModel: detailViewModel)
        schoolDetailVC.coordinator = self
        self.navigationController.pushViewController(schoolDetailVC, animated: true)
    }
    
    func presentSchoolWebsite(detailViewModel: SchoolDetailViewModel) {
        guard let url = detailViewModel.webAddress else { return }
        let vc = SFSafariViewController(url: url)
        self.navigationController.topViewController?.present(vc, animated: true)
    }
    
}
