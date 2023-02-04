//
//  SchoolDetailViewController.swift
//  NYCSchoolsWithCombine
//
//  Created by iAskedYou2nd on 12/29/22.
//

import UIKit
import Combine

class SchoolDetailViewController: UIViewController {

    lazy var schoolMapView: SchoolMapView = {
        let view = SchoolMapView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return view
    }()
    
    lazy var schoolInfoView: SchoolInfoView = {
        let view = SchoolInfoView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var schoolWebSiteButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.schoolWebsiteButtonPressed), for: .touchUpInside)
        let attributes = [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 14),
                          NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        let attrString = NSAttributedString(string: self.schoolDetailViewModel.webAddress?.absoluteString ?? "", attributes: attributes)
        button.setAttributedTitle(attrString, for: .normal)
        button.backgroundColor = .clear
        button.heightAnchor.constraint(equalToConstant: 15).isActive = true
        return button
    }()
    
    weak var coordinator: SchoolCoordinator?
    private let schoolDetailViewModel: SchoolDetailViewModel
    private var subs = Set<AnyCancellable>()
    
    init(viewModel: SchoolDetailViewModel) {
        self.schoolDetailViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.setDynamicBackgroundColor()
        let vStack = UIStackView(frame: .zero)
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.spacing = 8
        
        vStack.addArrangedSubview(self.schoolMapView)
        vStack.addArrangedSubview(self.schoolInfoView)
        vStack.addArrangedSubview(self.schoolWebSiteButton)
        
        
        self.view.addSubview(vStack)
        vStack.bindToSuper()
        
        self.schoolDetailViewModel.$schoolSATScores
            .delay(for: 0.1, scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.schoolInfoView.configure(schoolDetailViewModel: self?.schoolDetailViewModel)
                self?.schoolMapView.configure(schoolDetailViewModel: self?.schoolDetailViewModel)
            }
            .store(in: &self.subs)
        
        
        self.schoolDetailViewModel.requestSATScores()
    }
    
    @objc
    func schoolWebsiteButtonPressed() {
        self.coordinator?.presentSchoolWebsite(detailViewModel: self.schoolDetailViewModel)
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.view.setDynamicBackgroundColor()
    }
    
}
