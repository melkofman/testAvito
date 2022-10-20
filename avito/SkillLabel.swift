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
//        let labelH: CGFloat = 20
//        let labelW: CGFloat = 80
        

//                        self.myLabel.frame = CGRect(x: 0, y: 0, width: labelW, height: labelH)
        self.myLabel.textAlignment = NSTextAlignment.center
        self.addSubview(self.myLabel)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = Brandbook.CornerRadius.normal
        myLabel.text = ""
        myLabel.font = UIFont.systemFont(ofSize: Brandbook.TextSize.small)
        sizeToFit()
        myLabel.numberOfLines = 0
        myLabel.paddingTop = Brandbook.Padding.small
        myLabel.paddingBottom = Brandbook.Padding.small
        myLabel.paddingRight = Brandbook.Padding.light
        myLabel.paddingLeft = Brandbook.Padding.light

        
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        myLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        myLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        
    }
    
    func text(_ text: String) {
        self.myLabel.text = text
    }
        }

