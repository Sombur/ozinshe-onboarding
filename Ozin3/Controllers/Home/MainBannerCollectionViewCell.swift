//
//  MainBannerCVC.swift
//  Ozin3
//
//  Created by Самал Буранбаева on 12.02.2024.
//

import SnapKit
import SDWebImage


class MainBannerCollectionViewCell: UICollectionViewCell {
    
    let posterImage = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        
        return image
    }()
    
    let categoryView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = UIColor(named: "7E2DFC")
        
        return view
    }()
    
    let categoryLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        label.textColor = .white
        
        return label
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "111827-FFFFFF")
        
        return label
    }()
    
    let descriptionLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Medium", size: 12)
        label.textColor = UIColor(named: "9CA3AF")
        
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
        contentView.addSubview(categoryView)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        
        posterImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(164)
        }
        categoryView.snp.makeConstraints { make in
            make.top.equalTo(posterImage).inset(8)
            make.left.equalTo(posterImage).inset(8)
        }
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryView).inset(4)
            make.bottom.equalTo(categoryView).inset(4)
            make.left.equalTo(categoryView).inset(8)
            make.right.equalTo(categoryView).inset(8)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImage.snp.bottom).offset(16)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    //MARK: - setData
    func setData(bannerMovies: BannerMovie) {
        posterImage.sd_setImage(with: URL(string: bannerMovies.link))
        titleLabel.text = bannerMovies.movie.name
        categoryLabel.text = bannerMovies.movie.categories.first?.name
        descriptionLabel.text = bannerMovies.movie.description
    }
}
