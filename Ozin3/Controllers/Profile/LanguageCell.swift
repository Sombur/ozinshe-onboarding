//
//  LanguageCell.swift
//  Ozin3
//
//  Created by Самал Буранбаева on 08.02.2024.
//

import SnapKit

class LanguageCell: UITableViewCell {
    
    let label1: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        label.textColor = UIColor(named: "TextBlack")
        
        return label
    }()
    
    let image1: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Check")
        
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(label1)
        contentView.addSubview(image1)
        
        label1.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(24)
            make.centerY.equalToSuperview()
        }
        image1.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
