//
//  TableCell.swift
//  avito
//
//  Created by Melanie Kofman on 18.10.2022.
//

import Foundation
import UIKit
class TableCell: UITableViewCell {
    static let reusedId         = "cellId"
    var colors: [UIColor]       = [Brandbook.Colors.teal,
                                   Brandbook.Colors.yellow,
                                   Brandbook.Colors.brown,
                                   Brandbook.Colors.green,
                                   Brandbook.Colors.indigo,
                                   Brandbook.Colors.pink,
                                   Brandbook.Colors.orange]
    var labels: [SkillLabel]    = []
    var tagView: [UIStackView]  = []
    var n: Int                  = 0
    
    let labelNameText: UILabel = {
        let label                                       = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines                             = 0
        label.text                                      = "Name: "
        label.font                                      = UIFont(name: "SF Pro",
                                                           size: Brandbook.TextSize.body)
        label.sizeToFit()
        return label
    }()
    
    let labelName: UILabel = {
        let label                                       = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines                             = 0
        label.font                                      = UIFont(name: "SF Pro",
                                                           size: Brandbook.TextSize.body)
        label.sizeToFit()
        return label
    }()
    
    let labelTelText: UILabel = {
        let label                                       = UILabel()
        label.numberOfLines                             = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text                                      = "Tel number: "
        label.font                                      = UIFont(name: "SF Pro",
                                                           size: Brandbook.TextSize.body)
        label.sizeToFit()
        return label
    }()
    
    let labelTel: UILabel = {
        let label                                       = UILabel()
        label.numberOfLines                             = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font                                      = UIFont(name: "SF Pro",
                                                           size: Brandbook.TextSize.body)
        label.sizeToFit()
        return label
    }()
    
    let skillsView: UIStackView = {
        let view          = UIStackView()
        view.axis         = .vertical
        view.distribution = .fillEqually
        view.spacing      = Brandbook.Padding.big
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor     = .white
        self.layer.masksToBounds = true
        
        addSubview(labelNameText)
        labelNameText.topAnchor.constraint(equalTo: self.topAnchor, constant: Brandbook.Padding.small).isActive        = true
        labelNameText.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Brandbook.Padding.normal).isActive     = true
        
        addSubview(labelName)
        labelName.topAnchor.constraint(equalTo: self.topAnchor, constant: Brandbook.Padding.small).isActive            = true
        labelName.leftAnchor.constraint(equalTo: labelNameText.rightAnchor,constant: Brandbook.Padding.small).isActive = true
        
        addSubview(labelTelText)
        labelTelText.topAnchor.constraint(equalTo: labelNameText.bottomAnchor,
                                          constant: Brandbook.Padding.small).isActive = true
        labelTelText.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Brandbook.Padding.normal).isActive      = true
        
        addSubview(labelTel)
        labelTel.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: Brandbook.Padding.small).isActive     = true
        labelTel.leftAnchor.constraint(equalTo: labelTelText.rightAnchor, constant: Brandbook.Padding.small).isActive  = true
        
        addSubview(skillsView)
        skillsView.topAnchor.constraint(equalTo: labelTel.bottomAnchor, constant: Brandbook.Padding.small).isActive    = true
        skillsView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Brandbook.Padding.normal).isActive        = true
        skillsView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -Brandbook.Padding.normal).isActive     = true
        skillsView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Brandbook.Padding.normal).isActive   = true
        
    }
    
    func clear() {
        for i in tagView {
            for label in labels {
                i.removeArrangedSubview(label)
                NSLayoutConstraint.deactivate(label.constraints)
                label.removeFromSuperview()
            }
            i.removeAllArrangedSubviews()
        }
        
        skillsView.removeAllArrangedSubviews()
        tagView.removeAll()
        labels.removeAll()
    }
    
    func countN() {
    //Подсчет количества tagView в зависимости от длин view с лэйблами
        let widthScreen = UIScreen.main.bounds.width-Brandbook.Padding.normal
        var width = 0.0
        
        for i in labels {
            while width < widthScreen {
                width += i.frame.width + Brandbook.Padding.normal
            }
            if width > widthScreen {
                n += 1
                width = 0
            }
        }
    }
    
    func setSkillsLabels(skills: [String]) {
    //создание массива лэйблов для добавления в stackView
        for (_, element) in skills.enumerated() {
            let label = SkillLabel(frame: CGRect(x: 0, y: 0,
                                                 width: element.ga_widthForComment(fontSize: Brandbook.TextSize.small),
                                                 height: 20))
            label.text(element)
            label.backgroundColor = colors.randomElement()
            labels.append(label)
            
        }
        
        countN()
        var i = 0
        let tagView          = UIStackView()
        tagView.axis         = .horizontal
        tagView.distribution = .fillEqually
        tagView.spacing      = Brandbook.Padding.normal
        tagView.translatesAutoresizingMaskIntoConstraints = false
        
        while i <= n {
            
            for (_, element) in labels.enumerated() {
            // добавление лэйблов (view с лэйблами) на tagView
                var width = 0.0
                let screenWidth = UIScreen.main.bounds.width - Brandbook.Padding.normal*2
                while width < screenWidth {
                    tagView.addArrangedSubview(element)
                    element.bottomAnchor.constraint(equalTo: tagView.bottomAnchor).isActive = true
                    width = width + element.frame.width + Brandbook.Padding.normal
                }
                if width > screenWidth {
                    self.tagView.append(tagView)
                    width = 0.0
                    i += 1
                }
            }
        }
        for tag in self.tagView {
        // добавление tagView на skillsView
            skillsView.addArrangedSubview(tag)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension String {
    func ga_widthForComment(fontSize: CGFloat, height: CGFloat = Brandbook.TextSize.small) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.width)
    }
    
}

extension UIStackView {
    func removeAllArrangedSubviews() {
        arrangedSubviews.forEach {
            self.removeArrangedSubview($0)
            NSLayoutConstraint.deactivate($0.constraints)
            $0.removeFromSuperview()
        }
    }
}
