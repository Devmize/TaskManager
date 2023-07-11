//
//  UIView.swift
//  TaskManager
//
//  Created by Евгений Мизюк on 11.05.2023.
//

import UIKit

extension UIView {
    
    @objc func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        addGestureRecognizer(tapGesture)
    }
    
    var topSuperview: UIView? {
        var view = superview
        while view?.superview != nil {
            view = view!.superview
        }
        return view
    }
    
    @objc func dismissKeyboard() {
        topSuperview?.endEditing(true)
    }
}
