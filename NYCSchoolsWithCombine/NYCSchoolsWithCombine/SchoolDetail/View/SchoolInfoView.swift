//
//  SchoolInfoView.swift
//  NYCSchoolsWithCombine
//
//  Created by iAskedYou2nd on 12/29/22.
//

import UIKit

class SchoolInfoView: UIView {

    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textAlignment = .left
        return label
    }()
    
    lazy var overviewLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left

        return label
    }()
    
    lazy var addressLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.italicSystemFont(ofSize: 12)
        label.textAlignment = .left
        return label
    }()
    
    lazy var readingScoreLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var mathScoreLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var writingScoreLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createUI() {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        let vStack = UIStackView(frame: .zero)
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.spacing = 8
        vStack.axis = .vertical
        
        vStack.addArrangedSubview(self.titleLabel)
        vStack.addArrangedSubview(self.addressLabel)
        vStack.addArrangedSubview(self.overviewLabel)
        
        let satTitleLabel = UILabel(frame: .zero)
        satTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        satTitleLabel.text = "Avg SAT Score"
        satTitleLabel.textAlignment = .center
        satTitleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        vStack.addArrangedSubview(satTitleLabel)
        
        let hStack = UIStackView(frame: .zero)
        hStack.translatesAutoresizingMaskIntoConstraints = false
        hStack.spacing = 8
        hStack.axis = .horizontal
        
        hStack.addArrangedSubview(self.readingScoreLabel)
        hStack.addArrangedSubview(self.mathScoreLabel)
        hStack.addArrangedSubview(self.writingScoreLabel)
        
        vStack.addArrangedSubview(hStack)
        vStack.addArrangedSubview(UIView.createBufferView())
        
        scrollView.addSubview(vStack)
        vStack.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor).isActive = true
        vStack.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor).isActive = true
        vStack.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor).isActive = true
        vStack.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor).isActive = true

        vStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        self.addSubview(scrollView)
        scrollView.bindToSuper(constant: 0)
    }
    
    func configure(schoolDetailViewModel: SchoolDetailViewModel?) {
        self.titleLabel.text = schoolDetailViewModel?.schoolName
        self.addressLabel.text = schoolDetailViewModel?.address
        self.overviewLabel.text = schoolDetailViewModel?.schoolOverview
        self.readingScoreLabel.text = schoolDetailViewModel?.readingScore
        self.mathScoreLabel.text = schoolDetailViewModel?.mathScore
        self.writingScoreLabel.text = schoolDetailViewModel?.writingScore
    }
    
}
