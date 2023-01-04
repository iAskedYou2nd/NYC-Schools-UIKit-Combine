//
//  SchoolListViewController.swift
//  NYCSchoolsWithCombine
//
//  Created by iAskedYou2nd on 12/29/22.
//

import UIKit
import Combine

class SchoolListViewController: UIViewController {

    lazy var schoolTable: UITableView = {
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(SchoolTableViewCell.self, forCellReuseIdentifier: SchoolTableViewCell.reuseID)
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    weak var coordinator: SchoolCoordinator?
    private let schoolListViewModel: SchoolListViewModel
    private var subs = Set<AnyCancellable>()
    
    init(schoolListViewModel: SchoolListViewModel) {
        self.schoolListViewModel = schoolListViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "NYC Schools"
        
        self.view.backgroundColor = .white
        self.view.addSubview(self.schoolTable)
        self.schoolTable.bindToSuper()
        
        self.schoolListViewModel.$schoolList
            .dropFirst()
            .delay(for: 0.1, scheduler: DispatchQueue.main)
            .sink(receiveValue: { _ in
                self.schoolTable.reloadData()
                
            })
            .store(in: &self.subs)
        
        self.schoolListViewModel.requestSchools()
    }
    
}

extension SchoolListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.schoolListViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SchoolTableViewCell.reuseID, for: indexPath) as? SchoolTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(schoolDetailViewModel: self.schoolListViewModel.schoolDetailViewModel(for: indexPath.row))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.coordinator?.pushSchoolDetail(detailViewModel: self.schoolListViewModel.schoolDetailViewModel(for: indexPath.row))
    }
    
}
