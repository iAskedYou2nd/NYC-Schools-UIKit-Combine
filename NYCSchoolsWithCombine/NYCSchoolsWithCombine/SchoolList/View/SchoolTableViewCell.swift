//
//  SchoolTableViewCell.swift
//  NYCSchoolsWithCombine
//
//  Created by iAskedYou2nd on 12/29/22.
//

import UIKit

class SchoolTableViewCell: UITableViewCell {

    static let reuseID = "\(SchoolTableViewCell.self)"
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title"
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    lazy var overviewLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Overview"
        label.numberOfLines = 3
        label.textAlignment = .left
        return label
    }()
    
    lazy var zipcodeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "zip"
        label.numberOfLines = 0
        label.textAlignment = .right
        return label
    }()
    
    var schoolDetailViewModel: SchoolDetailViewModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createUI() {
        let hStack = UIStackView(frame: .zero)
        hStack.translatesAutoresizingMaskIntoConstraints = false
        hStack.axis = .horizontal
        
        hStack.addArrangedSubview(self.titleLabel)
        hStack.addArrangedSubview(self.zipcodeLabel)
        
        let vStack = UIStackView(frame: .zero)
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.spacing = 8
        
        vStack.addArrangedSubview(hStack)
        vStack.addArrangedSubview(self.overviewLabel)
        
        self.contentView.addSubview(vStack)
        vStack.bindToSuper()
    }
    
    func configure(schoolDetailViewModel: SchoolDetailViewModel?) {
        self.schoolDetailViewModel = schoolDetailViewModel
        
        self.titleLabel.text = schoolDetailViewModel?.schoolName
        self.zipcodeLabel.text = "Zip: \(schoolDetailViewModel?.zipcode ?? "N/Ap")"
        self.overviewLabel.text = schoolDetailViewModel?.schoolOverview
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = "Title"
        self.zipcodeLabel.text = "ZipCode"
        self.overviewLabel.text = "Overview"
    }

}
