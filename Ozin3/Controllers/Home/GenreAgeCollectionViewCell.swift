//
//  GenreCVC.swift
//  Ozin3
//
//  Created by Самал Буранбаева on 17.02.2024.
//

import UIKit

class GenreAgeCollectionViewCell: UICollectionViewCell {
    
    let posterImage = {
        let image = UIImageView()
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = UIColor.white
        
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
    //MARK: - setupUI
    func setupUI() {
        contentView.addSubview(posterImage)
        contentView.addSubview(titleLabel)
        
        posterImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(112)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(posterImage)
            make.centerY.equalTo(posterImage)
        }
    }
    //MARK: - setData
    func setData(movies: Movie ) {
        titleLabel.text = movies.genres.first?.name ?? ""
        posterImage.sd_setImage(with: URL(string: movies.poster_link)!)
    }
}
