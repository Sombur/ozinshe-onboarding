//
//  MovieInfoVC.swift
//  Ozin3
//
//  Created by Самал Буранбаева on 09.02.2024.
//

import SnapKit
import Alamofire
import SDWebImage
import Localize_Swift
import SVProgressHUD


class MovieInfoVC: UIViewController {
    
    var movie = Movie()
    
    lazy var scrollView = {
        let sv = UIScrollView()
        //sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
    }()
    
    lazy var contentView = {
        let view = UIView()
        // view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var posterImage = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.backgroundColor = .red
        // image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    let playButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Play1"), for: .normal)
        
        return button
    }()
    
    let favoriteButton = {
        let button = UIButton(type: .system)
        let image = UIImageView(image: UIImage(named: "Favorite2"))
        let label = UILabel()
        
        image.contentMode = .scaleAspectFill
        label.text = "Тізімге қосу"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        label.textColor = UIColor(named: "TextGray")
        
        let stackView = UIStackView(arrangedSubviews: [image, label])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5
        button.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: button.centerYAnchor)])
        
        return button
    }()
    
    let sendButton = {
        let button = UIButton(type: .system)
        let image = UIImageView(image: UIImage(named: "Send"))
        let label = UILabel()
        
        image.contentMode = .scaleAspectFill
        label.text = "Бөлісу"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        label.textColor = UIColor(named: "TextGray")
        
        let stackView = UIStackView(arrangedSubviews: [image, label])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5
        button.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: button.centerYAnchor)])
        
        return button
    }()
    
    let backgraundView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "BackgraundColor")
        view.layer.cornerRadius = 32
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        return view
    }()
    
    let nameLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "TextBlack")
        
        return label
    }()
    
    let label2 = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        label.textColor = UIColor(named: "TextGray")
        
        return label
    }()
    
    let lineView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "ViewColor")
        
        return view
    }()
    
    let descriptionLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF-Pro-Display-Regular", size: 14)
        label.textColor = UIColor(named: "TextGray3")
        label.numberOfLines = 4
        
        return label
    }()
    
    let gradient = {
        let g = GradientView()
        
        return g
    }()
    
    let fullDescrButton = {
        let button = UIButton()
        button.setTitle("Толығырақ", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        button.setTitleColor(UIColor(named: "LightPurple"), for: .normal)
        button.addTarget(self, action: #selector(showFullDescription), for: .touchUpInside)
        
        return button
    }()
    
    let directorLabel = {
        let label = UILabel()
        label.text = "Режиссер:"
        label.font = UIFont(name: "SF-Pro-Display-Regular", size: 14)
        label.textColor = UIColor(named: "TextGray1")
        
        return label
    }()
    
    let directorNameLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF-Pro-Display-Regular", size: 14)
        label.textColor = UIColor(named: "TextGray3")
        
        return label
    }()
    
    let producerLabel = {
        let label = UILabel()
        label.text = "Продюсер:"
        label.font = UIFont(name: "SF-Pro-Display-Regular", size: 14)
        label.textColor = UIColor(named: "TextGray1")
        
        return label
    }()
    
    let producerNameLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF-Pro-Display-Regular", size: 14)
        label.textColor = UIColor(named: "TextGray3")
        
        return label
    }()
    
    let lineView2 = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "ViewColor")
        
        return view
    }()
    
    let seasonLabel = {
        let label = UILabel()
        label.text = "Бөлімдер"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = UIColor(named: "TextBlack")
        
        return label
    }()
    
    let seasonButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "Chevron"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.contentHorizontalAlignment = .leading
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        button.sizeToFit()
        button.setTitleColor(UIColor(named: "TextGray3"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        
        return button
    }()
    
    let screenshotLabel = {
        let label = UILabel()
        label.text = "Скриншоттар"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = UIColor(named: "TextBlack")
        
        return label
        }()
    
    let screenshotCollectionView = {
        let layout = TopAlignedCollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        //layout.minimumLineSpacing = 0
        layout.itemSize = UIScreen.main.bounds.size
        layout.sectionInset = UIEdgeInsets(top: 22.0, left: 24.0, bottom: 10.0, right: 24.0)
        layout.itemSize = CGSize(width: 300, height: 220)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(MovieInfoCell.self, forCellWithReuseIdentifier: "Cell")
        cv.backgroundColor = .red
        cv.isPagingEnabled = true
        cv.isScrollEnabled = true
        cv.showsHorizontalScrollIndicator = false
//        cv.showsVerticalScrollIndicator = false
//        cv.contentInsetAdjustmentBehavior = .never
        
        let collectionView = {
            let layout = TopAlignedCollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 22.0, left: 24.0, bottom: 10.0, right: 24.0)
            layout.itemSize = CGSize(width: 300, height: 220)
//            layout.minimumInteritemSpacing = 16
//            layout.minimumLineSpacing = 16
           // layout.scrollDirection = .horizontal
            
            let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
            cv.register(MainBannerCVC.self, forCellWithReuseIdentifier: "MainBannerCVC")
         //   cv.showsHorizontalScrollIndicator = false
            cv.backgroundColor = .red
            
            return cv
        }()
        return cv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setData()
    }
    func setupUI() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(posterImage)
        contentView.addSubview(playButton)
        contentView.addSubview(favoriteButton)
        contentView.addSubview(sendButton)
        contentView.addSubview(backgraundView)
        
        //backgraundView.addSubview(gradient)
        backgraundView.addSubview(nameLabel)
        backgraundView.addSubview(label2)
        backgraundView.addSubview(lineView)
        backgraundView.addSubview(descriptionLabel)
        descriptionLabel.addSubview(gradient)
        backgraundView.addSubview(fullDescrButton)
        backgraundView.addSubview(directorLabel)
        backgraundView.addSubview(directorNameLabel)
        backgraundView.addSubview(producerLabel)
        backgraundView.addSubview(producerNameLabel)
        backgraundView.addSubview(lineView2)
        backgraundView.addSubview(seasonLabel)
        backgraundView.addSubview(seasonButton)
        backgraundView.addSubview(screenshotLabel)
        backgraundView.addSubview(screenshotCollectionView)
        
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        posterImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(363)
        }
        playButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(222)
            make.centerX.equalToSuperview()
            make.width.equalTo(132)
            make.height.equalTo(132)
        }
        favoriteButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(260)
            make.left.equalToSuperview().inset(50)
            make.width.equalTo(77)
            make.height.equalTo(59)
        }
        sendButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(260)
            make.right.equalToSuperview().inset(50)
            make.width.equalTo(77)
            make.height.equalTo(59)
        }
        backgraundView.snp.makeConstraints { make in
            make.top.equalTo(posterImage.snp.bottom).inset(24)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(1000)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.left.equalToSuperview().inset(24)
        }
        label2.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().inset(24)
        }
        lineView.snp.makeConstraints { make in
            make.top.equalTo(label2.snp.bottom).offset(24)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(24)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
        }
        gradient.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        fullDescrButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().inset(24)
        }
        directorLabel.snp.makeConstraints { make in
            make.top.equalTo(fullDescrButton.snp.bottom).offset(24)
            make.left.equalToSuperview().inset(24)
        }
        directorNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(directorLabel)
            make.left.equalTo(directorLabel.snp.right).offset(19)
        }
        producerLabel.snp.makeConstraints { make in
            make.top.equalTo(directorLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().inset(24)
        }
        producerNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(producerLabel)
            make.left.equalTo(producerLabel.snp.right).offset(19)
        }
        lineView2.snp.makeConstraints { make in
            make.top.equalTo(producerLabel.snp.bottom).offset(24)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        seasonLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView2.snp.bottom).offset(24)
            make.left.equalToSuperview().inset(24)
        }
        seasonButton.snp.makeConstraints { make in
            make.centerY.equalTo(seasonLabel)
            make.left.equalTo(seasonLabel.snp.right)
            make.right.equalToSuperview().inset(24)
        }
        screenshotLabel.snp.makeConstraints { make in
            make.top.equalTo(seasonLabel.snp.bottom).offset(32)
            make.left.equalToSuperview().inset(24)
        }
        screenshotCollectionView.dataSource = self
        screenshotCollectionView.delegate = self
        screenshotCollectionView.snp.makeConstraints { make in
            make.top.equalTo(screenshotLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().inset(24)
        }
    }
    func setData() {
        posterImage.sd_setImage(with: URL(string: movie.poster_link))
        nameLabel.text = movie.name
        label2.text = "\(movie.year) • \(movie.genres.first?.name ?? "")"
        descriptionLabel.text = movie.description
        directorNameLabel.text = movie.director
        producerNameLabel.text = movie.producer
        seasonButton.setTitle("\(movie.seasonCount) sezon \(movie.seriesCount) seria", for: .normal)
        
        //        descriptionLabel.numberOfLines = 4
        //        if descriptionLabel.numberOfLines < 5 {
        //            fullDescrButton.isHidden = true
        //            gradient.isHidden = true
    }
    
    @IBAction func showFullDescription(_ sender: Any) {
        if descriptionLabel.numberOfLines == 4 {
            //pokazat
            descriptionLabel.numberOfLines = 0
            fullDescrButton.setTitle("Жасыру", for: .normal)
            gradient.isHidden = true
        } else {
            //skryt
            descriptionLabel.numberOfLines = 4
            fullDescrButton.setTitle("Толығырақ", for: .normal)
            gradient.isHidden = false
        }
    }
}
extension MovieInfoVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie.screenshots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = screenshotCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MovieInfoCell
        cell.screenshotImage.sd_setImage(with: URL(string: movie.screenshots[indexPath.row].link))
        return cell
        
    }    
}
