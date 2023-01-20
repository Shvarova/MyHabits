//
//  ExtensionUIView.swift
//  MyHabits
//
//  Created by Дина Шварова on 09.01.2023.
//

import UIKit

extension UIView {
    func addSubviews (_ subViews: [UIView]) {
        subViews.forEach { view in
            addSubview(view)
        }
    }
}

