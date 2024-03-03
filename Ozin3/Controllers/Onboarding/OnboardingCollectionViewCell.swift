//
//  OnboardingCell.swift
//  Ozin3
//
//  Created by Самал Буранбаева on 24.01.2024.
//

import UIKit
import Localize_Swift


class OnboardingCollectionViewCell: UICollectionViewCell {
    
    let posterImage = {
        let image = UIImageView()
        
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    let helloLabel = {
        let label = UILabel()
        
        label.text = "ÖZINŞE-ге қош келдің!"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "111827-FFFFFF")
        label.textAlignment = .center
        label.numberOfLines = 2
        
        return label
    }()
    
    let descriptionLabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(named: "6B7280-9CA3AF")
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        
        return label
    }()
    
    let scipButton = {
        
        let button = UIButton()
        
        button.setTitle("Өткізу", for: .normal)
        button.setTitleColor(UIColor(named: "111827-FFFFFF"), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        button.layer.backgroundColor = UIColor(named: "F9FAFB-111827")?.cgColor
        
        return button
    }()
    
    let nextButton = {
        let button = UIButton()
        
        button.setTitle("Әрі қарай", for: .normal)
        button.backgroundColor = UIColor(named: "7E2DFC")
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
    
    func setData() {
        helloLabel.text = "WELCOME".localized()
        scipButton.setTitle("SKIP".localized(), for: .normal)
        nextButton.setTitle("NEXT".localized(), for: .normal)
    }
    
    func SetupUI() {
        contentView.addSubview(posterImage)
        contentView.addSubview(helloLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(scipButton)
        contentView.addSubview(nextButton)
        
        
        posterImage.snp.makeConstraints { make in
            make.top.right.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        helloLabel.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(dynamicValue(for: 310))
            make.left.equalToSuperview().inset(40)
            make.right.equalToSuperview().inset(40)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(helloLabel.snp.bottom).offset(24)
            make.left.equalToSuperview().inset(32)
            make.right.equalToSuperview().inset(32)
        }
        scipButton.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(dynamicValue(for: 16))
            make.right.equalToSuperview().inset(24)
        }
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(dynamicValue(for: 72))
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
    }
}


