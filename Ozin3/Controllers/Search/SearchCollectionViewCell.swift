//
//  SearchCVC.swift
//  Ozin3
//
//  Created by Самал Буранбаева on 25.02.2024.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    let view1 = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = UIColor(named: "F3F4F6-374151")
        
        return view
    }()
    
    let label1 = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        label.textColor = UIColor(named: "374151-F9FAFB")
        
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - setupUI
    func setupUI() {
        contentView.addSubview(view1)
        contentView.addSubview(label1)
        
        view1.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        label1.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(34)
        }
    }
}
