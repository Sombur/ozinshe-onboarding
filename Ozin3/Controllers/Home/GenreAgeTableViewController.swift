//
//  GenreTVC.swift
//  Ozin3
//
//  Created by Самал Буранбаева on 17.02.2024.
//

import SnapKit
import Localize_Swift

class GenreAgeTableViewController: UITableViewCell {
    
    var mainMovie = MainMovies()
    var delegate: MovieProtocol?
    
    let titleLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = UIColor(named: "111827-FFFFFF")
        
        return label
    }()
    
    let collectionView = {
        let layout = TopAlignedCollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16.0, left: 24.0, bottom: 22.0, right: 24.0)
        layout.itemSize = CGSize(width: 184, height: 112)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(GenreAgeCollectionViewCell.self, forCellWithReuseIdentifier: "GenreCell")
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
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().inset(24)
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }
    //MARK: - setData
    func setData(movies: MainMovies) {
        self.mainMovie = movies
        if mainMovie.cellType == .genre {
            titleLabel.text = "CHOOSE_GENRE".localized()
        } else {
            titleLabel.text = "AGE_CATEGORY".localized()
        }
        collectionView.reloadData()
        
    }
}
// MARK: - CollectionView

extension GenreAgeTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if mainMovie.cellType == .ageCategory {
            return mainMovie.categoryAges.count
        }
        return mainMovie.genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCell", for: indexPath) as! GenreAgeCollectionViewCell
        
        if mainMovie.cellType == .ageCategory {
            cell.posterImage.sd_setImage(with: URL(string: mainMovie.categoryAges[indexPath.row].link), placeholderImage: nil)
            cell.titleLabel.text = mainMovie.categoryAges[indexPath.row].name
        } else {
            cell.posterImage.sd_setImage(with: URL(string: mainMovie.genres[indexPath.row].link), placeholderImage: nil)
            cell.titleLabel.text = mainMovie.genres[indexPath.row].name
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if mainMovie.cellType == .ageCategory {
            delegate?.ageDidSelect(id: mainMovie.categoryAges[indexPath.row].id, name: mainMovie.categoryAges[indexPath.row].name)
        } else {
            delegate?.genreDidSelect(id: mainMovie.genres[indexPath.row].id, name: mainMovie.genres[indexPath.row].name)
        }
    }
    
}
