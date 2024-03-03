//
//  MainTVC.swift
//  Ozin3
//
//  Created by Самал Буранбаева on 13.02.2024.
//

import UIKit
import SDWebImage
import Localize_Swift

class MainMovieTableViewController: UITableViewCell {
    
    var mainMovie = MainMovies()
    var movie: [Movie] = []
    
    var delegate: MovieProtocol?
    
    let mainLabel = {
        let label = UILabel()
        label.text = "Трендтегілер"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = UIColor(named: "111827-FFFFFF")
        
        return label
    }()
    
    let allLabel = {
        let label = UILabel()
        label.text = "Барлығы"
        label.textColor = UIColor(named: "B376F7")
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        
        return label
    }()
    
    let collectionView = {
        let layout = TopAlignedCollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16, left: 24.0, bottom: 22.0, right: 24.0)
        layout.itemSize = CGSize(width: 112, height: 224)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(MainMovieCollectionViewCell.self, forCellWithReuseIdentifier: "MainCell")
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
    //MARK: - setupUI
    func setupUI() {
        contentView.addSubview(mainLabel)
        contentView.addSubview(allLabel)
        contentView.addSubview(collectionView)
        
        mainLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().inset(24)
        }
        allLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(24)
            make.centerY.equalTo(mainLabel)
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    //MARK: - setData
    func setData(movies: MainMovies) {
        self.mainMovie = movies
        allLabel.text = "ALL".localized()
        mainLabel.text = mainMovie.categoryName
        
        collectionView.reloadData()
    }
}
// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension MainMovieTableViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainMovie.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCell", for: indexPath) as! MainMovieCollectionViewCell
        cell.setData(movies: mainMovie.movies[indexPath.row])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.movieDidSelect(movie: mainMovie.movies[indexPath.row])
        
    }
    
}
