//
//  UIView+Extension.swift
//  Movier
//
//  Created by Ricardo Sanchez-Macias on 4/1/24.
//

import UIKit

extension UIView {
    
    func constraint(to view: UIView, leading: CGFloat = 0, top: CGFloat = 0, trailing: CGFloat = 0, bottom: CGFloat = 0) {
        view.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailing).isActive = true
        self.topAnchor.constraint(equalTo: view.topAnchor, constant: top).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom).isActive = true
    }
    
}
