//
//  TableCell.swift
//  avito
//
//  Created by Melanie Kofman on 18.10.2022.
//

import Foundation
import UIKit
class TableCell: UITableViewCell {
    static let reusedId = "cellId"
    var labels: [PaddingLabel] = []
    var colors: [UIColor] = [Brandbook.Colors.teal, Brandbook.Colors.yellow, Brandbook.Colors.brown, Brandbook.Colors.green, Brandbook.Colors.indigo, Brandbook.Colors.pink, Brandbook.Colors.orange]
   
    let labelName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelTel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelSkills: UILabel = {
        let label = UILabel()
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .white
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 15
        
        addSubview(labelName)
        labelName.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        addSubview(labelTel)
        labelTel.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: Brandbook.Padding.normal).isActive = true
        

        
       
    }
    
    func setSkillsLabels(skills: [String]) {
        for (key, element) in skills.enumerated() {
            let label = PaddingLabel()
            label.backgroundColor = colors.randomElement()
            label.style()
            label.text = element
            labels.append(label)
        }


        for (key, element) in labels.enumerated() {
            addSubview(element)
            element.topAnchor.constraint(equalTo: labelTel.bottomAnchor, constant: Brandbook.Padding.small).isActive = true
            if key == 0 {
                element.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Brandbook.Padding.small).isActive = true
                
            }
            else {
                element.leftAnchor.constraint(equalTo: labels[key-1].rightAnchor, constant: Brandbook.Padding.small).isActive = true
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PaddingLabel {
    func style() {
//        backgroundColor = .cyan
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = true
        layer.cornerRadius = Brandbook.CornerRadius.normal
        text = ""
        font = UIFont.systemFont(ofSize: Brandbook.TextSize.small)
        paddingTop = Brandbook.Padding.small
        paddingBottom = Brandbook.Padding.small
        paddingRight = Brandbook.Padding.light
        paddingLeft = Brandbook.Padding.light
        
    }
}

