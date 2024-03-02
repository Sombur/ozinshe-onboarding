//
//  SeasonsTC.swift
//  Ozin3
//
//  Created by Самал Буранбаева on 23.02.2024.
//

import UIKit

class SeasonsTVC: UITableViewCell {
    
    let posterImage = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
       
        return image
    }()
    
    let seriasLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "TextBlack")
        
        return label
    }()
    
    let lineView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "LineView")
        
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(posterImage)
        contentView.addSubview(seriasLabel)
        contentView.addSubview(lineView)
        
        posterImage.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(24)
            make.height.equalTo(178)
        }
        seriasLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImage.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(24)
        }
        lineView.snp.makeConstraints { make in
            make.top.equalTo(seriasLabel.snp.bottom).offset(16)
            make.height.equalTo(1)
            make.left.right.equalToSuperview().inset(24)
        }
    }
}
