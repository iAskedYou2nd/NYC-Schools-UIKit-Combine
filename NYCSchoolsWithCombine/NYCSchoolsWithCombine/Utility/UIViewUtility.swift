//
//  UIViewUtility.swift
//  NYCSchoolsWithCombine
//
//  Created by iAskedYou2nd on 12/29/22.
//

import UIKit

extension UIView {
    
    static func createBufferView() -> UIView {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return view
    }
    
    func bindToSuper(constant: CGFloat = 8, isContentLayout: Bool = false) {
        guard let superViewSafeArea = self.superview?.safeAreaLayoutGuide else {
            fatalError("You forgot to add the view to the view hierarchy")
        }
        
        self.topAnchor.constraint(equalTo: superViewSafeArea.topAnchor, constant: constant).isActive = true
        self.leadingAnchor.constraint(equalTo: superViewSafeArea.leadingAnchor, constant: constant).isActive = true
        self.trailingAnchor.constraint(equalTo: superViewSafeArea.trailingAnchor, constant: -constant).isActive = true
        self.bottomAnchor.constraint(equalTo: superViewSafeArea.bottomAnchor, constant: -constant).isActive = true
    }
    
    func setDynamicBackgroundColor() {
        self.backgroundColor = .white | .black
    }
    
}
