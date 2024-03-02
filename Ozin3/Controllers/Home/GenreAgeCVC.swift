//
//  GenreCVC.swift
//  Ozin3
//
//  Created by Самал Буранбаева on 17.02.2024.
//

import UIKit

class GenreAgeCVC: UICollectionViewCell {
    
    let image1 = {
        let image = UIImageView()
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    let label1 = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
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
    func setupUI() {
        contentView.addSubview(image1)
        contentView.addSubview(label1)
        
        image1.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(112)
        }
        label1.snp.makeConstraints { make in
            make.centerX.equalTo(image1)
            make.centerY.equalTo(image1)
        }
    }
    func setData(movies: Movie ) {
        
        label1.text = movies.genres.first?.name ?? ""
        
        image1.sd_setImage(with: URL(string: movies.poster_link)!)
    }
}
