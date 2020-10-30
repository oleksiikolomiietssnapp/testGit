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
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 40)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.shadowColor = .black
        label.shadowOffset = CGSize(width: 2, height: 2)
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
