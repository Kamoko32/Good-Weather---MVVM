//
//  BindingTextField.swift
//  Good Weather
//
//  Created by Kamil Gucik on 07/05/2020.
//  Copyright © 2020 Kamil Gucik. All rights reserved.
//

import Foundation
import UIKit

class BindingTextField: UITextField {
    
    var textChangeClosure: (String) -> () = { _ in }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func bind(callback: @escaping (String) -> ()) {
        self.textChangeClosure = callback
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func commonInit() {
        self.addTarget(self, action: #selector(textFieldChange), for: .editingChanged)
    }
    
    @objc func textFieldChange(_ textField: UITextField) {
        
        if let text = textField.text {
            self.textChangeClosure(text)
        }
    }
}
