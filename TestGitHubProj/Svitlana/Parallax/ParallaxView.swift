//
//  IntitaMainScreenView.swift
//  TestGitHubProj
//
//  Created by Svitlana Korostelova on 29.10.2020.
//

import UIKit

class IntitaMainScreenView: UIView {
    let intitaScreenLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderWidth = 0.5
        layer.backgroundColor = UIColor.black.cgColor
        layer.masksToBounds = true
        backgroundColor = .green
        
        addSubview(intitaScreenLabel)
        
        intitaScreenLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        intitaScreenLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        intitaScreenLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        intitaScreenLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
