//
//  MovieInfoCell.swift
//  Ozin3
//
//  Created by Самал Буранбаева on 11.02.2024.
//

import SnapKit
import SDWebImage

class MovieInfoCell: UICollectionViewCell {
    
    let screenshotImage = {
        let image = UIImageView()
        
        return image
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(screenshotImage)
        
        screenshotImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(112)
            make.width.equalTo(184)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
