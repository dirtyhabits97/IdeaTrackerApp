//
//  UIView+Extensions.swift
//  app-lib
//
//  Created by DIGITAL008 on 10/7/20.
//

import UIKit

public extension UIView {
    
    func pinToSuperview(margin: CGFloat = .zero) {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
        ])
    }
    
}
