//
//  LeftSideMenuHeaderView.swift
//  saleforce_ios
//
//  Created by Fulvio A. Moya on 1/12/20.
//  Copyright © 2020 Fulvio A. Moya. All rights reserved.
//

import UIKit

class MenuHeaderView: UIView {
    var adminImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    var descriptionButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitleColor(.darkGray, for: .normal)
        button.contentHorizontalAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    /*
    var stackButtonView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 0.0
       
        let menuImage = UIImage(named:"menuimages")
        let buttonMenu = UIButton()
      //  buttonMenu.setImage(menuImage, for: .normal)
        
        buttonMenu.tintColor = UIColor.systemTeal
        buttonMenu.setBackgroundImage(menuImage, for: .normal)
        buttonMenu.isUserInteractionEnabled = true
      //  buttonMenu.addTarget(self, action: #selector(ExecutiveViewController.didTapMenu), for: .touchUpInside)
        
     
        let image = UIImage(named:"reportimages")
        let buttonImage = UIButton()
        
        buttonImage.setImage(image, for: .normal)
        buttonImage.addTarget(self, action:#selector(MenuViewController.didTapMenu), for: .touchUpInside)
        buttonImage.contentMode = UIView.ContentMode.scaleAspectFill
        
      
     
        stackView.addArrangedSubview(buttonMenu)
        stackView.addArrangedSubview(buttonImage)
        //stackView.addArrangedSubview(buttonMenu1)
        return stackView
    }()
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(adminImageView)
        self.addSubview(descriptionButton)
      //  self.addSubview(stackButtonView)
        setupConstraints()
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
        
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            adminImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            adminImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 2),
            adminImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            descriptionButton.topAnchor.constraint(equalTo: self.topAnchor),
            descriptionButton.leadingAnchor.constraint(equalTo: adminImageView.trailingAnchor, constant: 16),
            descriptionButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            descriptionButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        /*
        NSLayoutConstraint.activate([
          stackButtonView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
        //  stackButtonView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
         //   stackButtonView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1),
            stackButtonView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.15),
            
           
            stackButtonView.topAnchor.constraint(equalTo: self.topAnchor, constant: 2),
              stackButtonView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
  
                ])
           */
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
