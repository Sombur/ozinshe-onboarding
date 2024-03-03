//
//  SameCV.swift
//  Ozin3
//
//  Created by Самал Буранбаева on 22.02.2024.
//

import UIKit

class SameCollectionViewCell: UICollectionViewCell {
    
    let posterImage = {
        let image = UIImageView()
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.contentMode = .scaleToFill
        
        return image
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        label.textColor = UIColor(named: "111827-FFFFFF")
        
        return label
    }()
    
    let categoryLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        label.textColor = UIColor(named: "9CA3AF")
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - setupUI
   func  setupUI() {
       contentView.addSubview(posterImage)
       contentView.addSubview(titleLabel)
       contentView.addSubview(categoryLabel)
       
       posterImage.snp.makeConstraints { make in
           make.top.equalToSuperview()
           make.left.equalToSuperview()
           make.right.equalToSuperview()
           make.height.equalTo(164)
       }
       titleLabel.snp.makeConstraints { make in
           make.top.equalTo(posterImage.snp.bottom).offset(8)
           make.left.right.equalToSuperview()
       }
       categoryLabel.snp.makeConstraints { make in
           make.top.equalTo(titleLabel.snp.bottom).offset(4)
           make.left.right.equalToSuperview()
       }
    }
}
