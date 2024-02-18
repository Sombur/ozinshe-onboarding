//
//  OnboardingCell.swift
//  Ozin3
//
//  Created by Самал Буранбаева on 24.01.2024.
//

import UIKit


class OnboardingCell: UICollectionViewCell {
    let imageView = {
        let image = UIImageView()
        
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    let helloLabel = {
        let label = UILabel()
        
        label.text = "ÖZINŞE-ге қош келдің!"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "TextBlack")
        label.textAlignment = .center
        
        return label
    }()
    
    let descriptionLabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "SF-Pro-Display-Regular", size: 14)
        label.textColor = UIColor(named: "TextGray")
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        
        return label
    }()
    
    let scipButton = {
        
        let button = UIButton()
        
        button.setTitle("Өткізу", for: .normal)
        button.setTitleColor(UIColor(named: "TextBlack"), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        
        return button
    }()
    
    let nextButton = {
        let button = UIButton()
        
        button.setTitle("Әрі қарай", for: .normal)
        button.backgroundColor = UIColor(named: "DarkPurple")
        button.layer.cornerRadius = 12
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        SetupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func SetupUI() {
       addSubview(imageView)
        addSubview(helloLabel)
        addSubview(descriptionLabel)
        addSubview(scipButton)
        addSubview(nextButton)
        
        
        imageView.snp.makeConstraints { make in
            make.top.right.left.equalToSuperview()
            //make.height.equalToSuperview().multipliedBy(0.6)
        }
        helloLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(473)
            make.left.equalToSuperview().inset(40)
            make.right.equalToSuperview().inset(40)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(helloLabel.snp.bottom).offset(24)
            make.left.equalToSuperview().inset(32)
            make.right.equalToSuperview().inset(32)
        }
        scipButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60)
            make.right.equalToSuperview().inset(24)
        }
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(72)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
    }
}


