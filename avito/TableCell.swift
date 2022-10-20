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
    var colors: [UIColor] = [Brandbook.Colors.teal, Brandbook.Colors.yellow, Brandbook.Colors.brown, Brandbook.Colors.green, Brandbook.Colors.indigo, Brandbook.Colors.pink, Brandbook.Colors.orange]
    var labels: [SkillLabel] = []
//    var labels: [PaddingLabel] = []
    var offset: CGFloat = 10
    
    let labelName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        label.numberOfLines = 0
        return label
    }()
    
    let labelTel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let skillsView: UIView = {
        let view = UIView()
//        view.axis = .vertical
//        view.alignment = .center
//        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        
        addSubview(skillsView)
        skillsView.topAnchor.constraint(equalTo: labelTel.bottomAnchor, constant: Brandbook.Padding.small).isActive = true
        skillsView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Brandbook.Padding.normal).isActive = true
        skillsView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -Brandbook.Padding.normal).isActive = true
        skillsView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        skillsView.backgroundColor = .red

        
       
    }
    
    func setSkillsLabels(skills: [String]) {
        for (_, element) in skills.enumerated() {
            print("skills array-> \(element)")
            let label = SkillLabel(frame: CGRect(x: 0, y: 0, width: 70, height: 20))
            label.text(element)
            
            label.backgroundColor = colors.randomElement()
            
            
            
            
            
//            let label = PaddingLabel()
//            label.backgroundColor = colors.randomElement()
//            label.style()
//            let font = UIFont.preferredFont(forTextStyle: .headline)
//            let attributes: [NSAttributedString.Key: Any] = [.font: font]
//            let size = element.size(withAttributes: attributes)
//            label.frame = CGRect(x: 0.0, y: 0.0, width: size.width + 10.0, height: size.height + 10.0)
//            label.text = element
            //                label.myLabel.style()
            
            //            label.text(element)
            labels.append(label)
        }
        print("labels")
        print(labels)
        
        
        
        
        var x = offset
        var y = offset
        for (key, element) in labels.enumerated() {
            element.frame = CGRect(x: x, y: y, width: element.frame.width, height: element.frame.height)
            x += element.frame.width + offset

            let nextElement = key <= labels.count - 2 ? labels[key+1] : labels[key]
            let nextElementWidth = nextElement.frame.width + offset

            if x + nextElementWidth > frame.width {
                x = offset
                y += element.frame.height + offset
            }

//            addSubview(element)
            
            
            skillsView.addSubview(element)
            
//            skillsView.addArrangedSubview(element)
//            skillsView.addSubview(element)
//            element.topAnchor.constraint(equalTo: skillsView.topAnchor, constant: Brandbook.Padding.small).isActive = true
//            element.bottomAnchor.constraint(equalTo: skillsView.bottomAnchor, constant: Brandbook.Padding.small).isActive = true
//            if key == 0 {
//                element.leftAnchor.constraint(equalTo: skillsView.leftAnchor, constant: Brandbook.Padding.small).isActive = true
//
//            }
//            else {
//                element.leftAnchor.constraint(equalTo: labels[key-1].rightAnchor, constant: Brandbook.Padding.small).isActive = true
//            }
        
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



