//
//  MainTVC.swift
//  Ozin3
//
//  Created by Самал Буранбаева on 13.02.2024.
//

import UIKit
import SDWebImage
import Localize_Swift

class MainTVC: UITableViewCell {
    
    var mainMovie = MainMovies()
    var movie: [Movie] = []
    
    var delegate: MovieProtocol?
    var button1Action: (() -> Void)?
    
    let label1 = {
        let label = UILabel()
        label.text = "Трендтегілер"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = UIColor(named: "TextBlack")
        
        return label
    }()
    
    let button1 = {
        let button = UIButton()
        button.setTitle("Барлығы", for: .normal)
        button.setTitleColor(UIColor(named: "LightPurple"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        button.addTarget(self, action: #selector(allButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    let collectionView = {
        let layout = TopAlignedCollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16, left: 24.0, bottom: 22.0, right: 24.0)
        layout.itemSize = CGSize(width: 112, height: 224)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(MainCVC.self, forCellWithReuseIdentifier: "MainCell")
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        
        return cv
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI() {
        contentView.addSubview(label1)
        contentView.addSubview(button1)
        contentView.addSubview(collectionView)
        
        label1.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().inset(24)
        }
        button1.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(24)
            make.centerY.equalTo(label1)
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(label1.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    func setData(movies: MainMovies) {
        self.mainMovie = movies
        button1.setTitle("ALL".localized(), for: .normal)
        label1.text = mainMovie.categoryName
        
        collectionView.reloadData()
    }
    @objc func allButtonTapped() {
        button1Action?()
        
    }
}
// MARK: - CollectionView
extension MainTVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainMovie.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCell", for: indexPath) as! MainCVC
        cell.setData(movies: mainMovie.movies[indexPath.row])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.movieDidSelect(movie: mainMovie.movies[indexPath.row])
        
    }
    
}
