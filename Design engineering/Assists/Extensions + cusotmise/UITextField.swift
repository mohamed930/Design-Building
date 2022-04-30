//
//  UITextField.swift
//  ShopApp Test
//
//  Created by Mohamed Ali on 28/04/2022.
//

import UIKit

extension UITextField {
    
    func setPadding(paddingValue:Int,PlaceHolder:String , Color:UIColor) {
                
        self.textAlignment = .right
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: paddingValue, height: 20))
        self.rightView = paddingView
        self.rightViewMode = .always
            
        self.attributedPlaceholder = NSAttributedString(string: PlaceHolder,
            attributes: [NSAttributedString.Key.foregroundColor: Color])
    }
}
