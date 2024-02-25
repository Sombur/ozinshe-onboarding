//
//  FavoritesCell.swift
//  Ozin3
//
//  Created by Самал Буранбаева on 09.02.2024.
//

import SnapKit
import SDWebImage

class MovieTableVieCell: UITableViewCell {
    
    let posterImage = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 8
        
        return image
    }()
    
    let nameLabel = {
        let label = UILabel()
        label.text = "Қызғалдақтар мекені"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "TextBlack")
        
        return label
    }()
    
    let yearLabel = {
        let label = UILabel()
        label.text = "2020"
        label.font = UIFont(name: "SF-Pro-Display-Regular", size: 12)
        label.textColor = UIColor(named: "TextGray")
        
        return label
    }()
    
    let playView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "LightPurple2")
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    let playImage = {
        let image = UIImageView()
        image.image = UIImage(named: "Play")
        
        return image
    }()
    
    let playLabel = {
        let label = UILabel()
        label.text = "Қарау"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 12)
        label.textColor = UIColor(named: "LightPurple")
        
        return label
    }()
    
    let lineView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "LineView")
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(named: "BackgraundColor")
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(posterImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(yearLabel)
        contentView.addSubview(playView)
        playView.addSubview(playImage)
        playView.addSubview(playLabel)
        contentView.addSubview(lineView)
        
        posterImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.left.equalToSuperview().inset(24)
            make.width.equalTo(71)
            make.height.equalTo(104)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.left.equalTo(posterImage.snp.right).offset(17)
        }
        yearLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.left.equalTo(nameLabel)
        }
        playView.snp.makeConstraints { make in
            make.top.equalTo(yearLabel.snp.bottom).offset(24)
            make.left.equalTo(yearLabel)
            make.width.equalTo(86)
            make.height.equalTo(20)
        }
        playImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(12)
            make.width.equalTo(16)
            make.height.equalTo(16)
        }
        playLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(playImage.snp.right).offset(4)
            make.right.equalToSuperview().inset(12)
        }
        lineView.snp.makeConstraints { make in
            make.top.equalTo(posterImage.snp.bottom).offset(24)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
    }
    func setData(movie: Movie) {
        posterImage.sd_setImage(with: URL(string: movie.poster_link))
        nameLabel.text = movie.name
        yearLabel.text = "\(movie.year)"
    }
}
