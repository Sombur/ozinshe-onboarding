//
//  HistoryCVC.swift
//  Ozin3
//
//  Created by Самал Буранбаева on 17.02.2024.
//

import UIKit

class HistoryCVC: UICollectionViewCell {
    
    let image1 = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        
        return image
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-SemiBold", size: 12)
        label.textColor = UIColor(named: "TextBlack")
        
        return label
    }()
    
    let categoryLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Medium", size: 12)
        label.textColor = UIColor(named: "TextGray4")
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI() {
        contentView.addSubview(image1)
        contentView.addSubview(titleLabel)
        contentView.addSubview(categoryLabel)
        
        image1.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(112)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(image1.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
        }
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.right.equalToSuperview()
        }
    }
    func setData(movie: Movie) {
        
        image1.sd_setImage(with: URL(string: movie.poster_link)!)
        titleLabel.text = movie.name
        categoryLabel.text = movie.categories.first?.name ?? ""
        
    }
}
