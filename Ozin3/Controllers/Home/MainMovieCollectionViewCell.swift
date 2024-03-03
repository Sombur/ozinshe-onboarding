//
//  MainCVC.swift
//  Ozin3
//
//  Created by Самал Буранбаева on 17.02.2024.
//

import SnapKit
import SDWebImage

class MainMovieCollectionViewCell: UICollectionViewCell {
    
    let posterImage = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        
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
        contentView.addSubview(titleLabel)
        contentView.addSubview(categoryLabel)
        
        posterImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
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
    //MARK: - setData
    func setData(movies: Movie) {
        posterImage.sd_setImage(with: URL(string: movies.poster_link))
        titleLabel.text = movies.name
        categoryLabel.text = movies.categories.first?.name
        
    }
}
