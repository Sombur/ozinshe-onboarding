//
//  HistoryTVC.swift
//  Ozin3
//
//  Created by Самал Буранбаева on 17.02.2024.
//

import SnapKit
import Localize_Swift

class HistoryTableViewController: UITableViewCell {
    
    var delegate: MovieProtocol?
    
    var movie: [Movie] = []
    
    let titleLabel = {
        let label = UILabel()
        label.text = "Қарауды жалғастырыңыз"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = UIColor(named: "111827-FFFFFF")
        
        return label
    }()
    
    let collectionView = {
        let layout = TopAlignedCollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16.0, left: 24.0, bottom: 10.0, right: 24.0)
        layout.itemSize = CGSize(width: 184, height: 156)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(HistoryCollectionViewCell.self, forCellWithReuseIdentifier: "HistoryCell")
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
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    //MARK: - setData
    func setData(movies: [Movie]) {
        titleLabel.text = "CONTINUE_PLAY".localized()
        self.movie = movies
        collectionView.reloadData()
    }
}
// MARK: - CollectionView

extension HistoryTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HistoryCell", for: indexPath) as! HistoryCollectionViewCell
        cell.setData(movie: movie[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        delegate?.movieDidSelect(movie: movie[indexPath.row])
    }
    
}
