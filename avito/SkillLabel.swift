//
//  SkillLabel.swift
//  avito
//
//  Created by Melanie Kofman on 20.10.2022.
//

import Foundation
import UIKit
class SkillLabel: UIView {
    let myLabel = PaddingLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addLabels()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addLabels() {
        
        self.addSubview(self.myLabel)
        sizeToFit()
        self.layer.masksToBounds = true
        self.layer.cornerRadius  = Brandbook.CornerRadius.normal
        myLabel.textAlignment    = NSTextAlignment.center
        myLabel.text             = ""
        myLabel.font             = UIFont.systemFont(ofSize: Brandbook.TextSize.small)
        myLabel.numberOfLines    = 0
        myLabel.paddingTop       = Brandbook.Padding.small
        myLabel.paddingBottom    = Brandbook.Padding.small
        myLabel.paddingRight     = Brandbook.Padding.light
        myLabel.paddingLeft      = Brandbook.Padding.light
        
        myLabel.translatesAutoresizingMaskIntoConstraints                      = false
        myLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive         = true
        myLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        myLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive   = true
    }
    
    func text(_ text: String) {
        self.myLabel.text = text
    }
}

