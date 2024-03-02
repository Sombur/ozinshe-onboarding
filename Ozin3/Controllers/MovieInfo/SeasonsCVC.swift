//
//  SeasonsCV.swift
//  Ozin3
//
//  Created by Самал Буранбаева on 23.02.2024.
//

import UIKit

class SeasonsCVC: UICollectionViewCell {
    
    let view1 = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "ViewPurple")
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    let seasonLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        label.textColor = UIColor(named: "TextView")
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(view1)
        contentView.addSubview(seasonLabel)
        
        view1.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        seasonLabel.snp.makeConstraints { make in
            make.top.equalTo(view1).inset(8)
            make.bottom.equalTo(view1).inset(8)
            make.left.equalTo(view1).inset(16)
            make.right.equalTo(view1).inset(16)
        }
    }
}
