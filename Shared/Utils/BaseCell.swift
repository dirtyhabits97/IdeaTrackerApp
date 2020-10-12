//
//  BaseCell.swift
//  app-lib
//
//  Created by DIGITAL008 on 10/4/20.
//

import Foundation
import UIKit

open class BaseCell<Model>: UITableViewCell {
    
    // MARK: - Lifecycle
    
    public override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initializeView()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        initializeView()
    }
    
    open func initializeView() { }
    
    open func configure(for model: Model) { }
    
}
