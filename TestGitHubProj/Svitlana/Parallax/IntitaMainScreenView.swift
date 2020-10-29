//
//  IntitaMainScreenView.swift
//  TestGitHubProj
//
//  Created by Svitlana Korostelova on 29.10.2020.
//

import UIKit

class IntitaMainScreenView: UIView {
    let intitaLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.shadowOffset = CGSize(width: 3, height: 3)
        label.layer.shadowOpacity = 0.8
        label.layer.shadowRadius = 2
        label.layer.shadowColor = CGColor.init(srgbRed: 1, green: 0, blue: 0, alpha: 1)
//        label.layer.shadowColor = CGColor.init(gray: 1, alpha: 1)
        label.textAlignment = .center
        label.textColor = .white
        label.isHighlighted = true
        label.highlightedTextColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderWidth = 0.5
        layer.backgroundColor = UIColor.black.cgColor
        layer.masksToBounds = true
        backgroundColor = .green
        
        addSubview(intitaLabel)
        
        intitaLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        intitaLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        intitaLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        intitaLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
