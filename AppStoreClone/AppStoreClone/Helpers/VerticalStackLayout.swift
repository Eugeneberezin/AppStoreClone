//
//  VerticalStackLayout.swift
//  AppStoreClone
//
//  Created by Eugene Berezin on 10/26/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import Foundation
import UIKit

class VerticalStackView: UIStackView {

    init(arrangedSubviews: [UIView], spacing: CGFloat = 0) {
        super.init(frame: .zero)
        
        arrangedSubviews.forEach({addArrangedSubview($0)})
        
        self.spacing = spacing
        self.axis = .vertical
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

