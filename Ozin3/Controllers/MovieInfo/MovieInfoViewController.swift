//
//  MovieInfoVC.swift
//  Ozin3
//
//  Created by Самал Буранбаева on 09.02.2024.
//
import UIKit
import SnapKit
import Alamofire
import SDWebImage
import Localize_Swift
import SVProgressHUD
import SwiftyJSON


class MovieInfoViewController: UIViewController {
    
    var movie = Movie()
    var sameMovies:[Movie] = []
    
    
    lazy var scrollView = {
        let sv = UIScrollView()
        sv.isScrollEnabled = true
        sv.contentMode = .scaleToFill
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
        sv.contentInsetAdjustmentBehavior = .never
        
        return sv
    }()
    
    lazy var contentView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "FFFFFF-111827")
        
        return view
    }()
    
    lazy var posterImage = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        
        return image
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.clear
        button.setImage(UIImage(named: "Back"), for: .normal)
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        return button
    }()
    
    let playButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Play1"), for: .normal)
        button.addTarget(self, action: #selector(playMovie), for: .touchUpInside)
        
        return button
    }()
    
    lazy var favoriteButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "FavoriteForMovie"), for: .normal)
        button.addTarget(self, action: #selector(addToFavorite), for: .touchUpInside)
        return button
    }()
    
    let favoriteButtonLabel = {
        let label = UILabel()
        label.text = "Тізімге қосу"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        label.textColor = UIColor(named: "D1D5DB-9CA3AF")
        return label
    }()
    
    lazy var sendButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Send"), for: .normal)
        button.addTarget(self, action: #selector(shareMovie), for: .touchUpInside)
        return button
    }()
    
    let sendButtonLabel = {
        let label = UILabel()
        label.text = "Бөлісу"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        label.textColor = UIColor(named: "D1D5DB-9CA3AF")
        return label
    }()
    
    let backgraundView = {
        let view = UIView()
        view.layer.cornerRadius = 32
        view.clipsToBounds = true
        view.backgroundColor = UIColor(named: "FFFFFF-111827")
        //view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        return view
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "111827-FFFFFF")
        
        return label
    }()
    
    let subTitleLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        label.textColor = UIColor(named: "9CA3AF")
        
        return label
    }()
    
    let lineView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "D1D5DB-1C2431")
        
        return view
    }()
    
    let descriptionLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Medium", size: 14)
        label.textColor = UIColor(named: "9CA3AF-E5E7EB")
        label.numberOfLines = 4
        
        return label
    }()
    
    var descriptionGradientView = {
        let gradient = GradientView()
        gradient.backgroundColor = .clear
        gradient.startColor = UIColor(named: "Transparent")!
        gradient.endColor = UIColor(named: "FFFFFF-111827")!
        gradient.startLocation = 0.01
        gradient.endLocation = 1.0
        gradient.horizontalMode = false
        gradient.diagonalMode = false
        
        return gradient
    }()
    
    let fullDescrButton = {
        let button = UIButton()
        button.setTitle("Толығырақ", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        button.setTitleColor(UIColor(named: "B376F7"), for: .normal)
        button.addTarget(self, action: #selector(showFullDescription), for: .touchUpInside)
        
        return button
    }()
    
    let directorLabel = {
        let label = UILabel()
        label.text = "Режиссер:"
        label.font = UIFont(name: "SFProDisplay-Medium", size: 14)
        label.textColor = UIColor(named: "4B5563")
        
        return label
    }()
    
    let directorNameLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Medium", size: 14)
        label.textColor = UIColor(named: "9CA3AF")
        
        return label
    }()
    
    let producerLabel = {
        let label = UILabel()
        label.text = "Продюсер:"
        label.font = UIFont(name: "SFProDisplay-Medium", size: 14)
        label.textColor = UIColor(named: "4B5563")
        
        return label
    }()
    
    let producerNameLabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Medium", size: 14)
        label.textColor = UIColor(named: "9CA3AF")
        
        return label
    }()
    
    let lineView2 = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "D1D5DB-1C2431")
        
        return view
    }()
    
    let seasonLabel = {
        let label = UILabel()
        label.text = "Бөлімдер"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = UIColor(named: "111827-FFFFFF")
        
        return label
    }()
    
    let seasonButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "Chevron"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.contentHorizontalAlignment = .leading
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        button.sizeToFit()
        button.setTitleColor(UIColor(named: "9CA3AF"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        button.addTarget(self, action: #selector(playMovie), for: .touchUpInside)
        
        return button
    }()
    
    let screenshotLabel = {
        let label = UILabel()
        label.text = "Скриншоттар"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = UIColor(named: "111827-FFFFFF")
        
        return label
    }()
    
    let sameLabel = {
        let label = UILabel()
        label.text = "Ұқсас телехикаялар"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = UIColor(named: "111827-FFFFFF")
        
        return label
    }()
    
    lazy var allButton = {
        let button = UIButton()
        button.setTitle("Барлығы", for: .normal)
        button.setTitleColor(UIColor(named: "B376F7"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        button.addTarget(self, action: #selector(allButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    let screenshotCollectionView = {
        let layout = TopAlignedCollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        //layout.minimumLineSpacing = 0
        layout.itemSize = UIScreen.main.bounds.size
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24.0, bottom: 0, right: 24.0)
        layout.itemSize = CGSize(width: 184, height: 112)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(MovieInfoCollectionCell.self, forCellWithReuseIdentifier: "MovieCell")
        cv.backgroundColor = .clear
        cv.isPagingEnabled = true
        cv.isScrollEnabled = true
        cv.showsHorizontalScrollIndicator = false
        
        return cv
    }()
    
    let sameCollectionView = {
        let layout = TopAlignedCollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        //layout.minimumLineSpacing = 0
        layout.itemSize = UIScreen.main.bounds.size
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24.0, bottom: 0, right: 24.0)
        layout.itemSize = CGSize(width: 112, height: 224)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(SameCollectionViewCell.self, forCellWithReuseIdentifier: "SameCell")
        cv.backgroundColor = .clear
        cv.isPagingEnabled = true
        cv.isScrollEnabled = true
        cv.showsHorizontalScrollIndicator = false
        
        return cv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "FFFFFF-111827")
        self.title = ""
        
        setupUI()
        setData()
        downloadSame()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        localizeLanguage()
        decriptionNumber()
        
        descriptionGradientView.updateColors()
        descriptionGradientView.updateLocations()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
    }
    //MARK: - setupUI
    func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(posterImage)
        contentView.addSubview(backButton)
        contentView.addSubview(playButton)
        contentView.addSubview(favoriteButton)
        contentView.addSubview(favoriteButtonLabel)
        contentView.addSubview(sendButton)
        contentView.addSubview(sendButtonLabel)
        contentView.addSubview(backgraundView)
        
        backgraundView.addSubview(titleLabel)
        backgraundView.addSubview(subTitleLabel)
        backgraundView.addSubview(lineView)
        backgraundView.addSubview(descriptionLabel)
        backgraundView.addSubview(descriptionGradientView)
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
        backgraundView.addSubview(sameLabel)
        backgraundView.addSubview(allButton)
        backgraundView.addSubview(sameCollectionView)
        
        
        scrollView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints { make in
            make.edges.horizontalEdges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
            make.height.equalTo(scrollView.frameLayoutGuide).priority(.medium)
        }
        posterImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(363)
        }
        backButton.snp.makeConstraints { make in
            make.size.equalTo(90)
            make.top.equalToSuperview().inset(60)
            make.left.equalToSuperview()
        }
        playButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(198)
            make.centerX.equalToSuperview()
            make.width.equalTo(132)
            make.height.equalTo(132)
        }
        favoriteButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(228)
            make.left.equalToSuperview().inset(37)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        favoriteButtonLabel.snp.makeConstraints { make in
            make.centerX.equalTo(favoriteButton)
            make.top.equalTo(favoriteButton.snp.top).offset(46)
        }
        sendButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(228)
            make.right.equalToSuperview().inset(37)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        sendButtonLabel.snp.makeConstraints { make in
            make.centerX.equalTo(sendButton)
            make.top.equalTo(sendButton.snp.top).offset(46)
        }
        backgraundView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(324)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.left.equalToSuperview().inset(24)
        }
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().inset(24)
        }
        lineView.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(24)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(24)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
        }
        descriptionGradientView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(descriptionLabel.snp.top)
            make.bottom.equalTo(descriptionLabel.snp.bottom)
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
            make.width.equalTo(75)
        }
        seasonButton.snp.makeConstraints { make in
            make.centerY.equalTo(seasonLabel)
            make.left.equalTo(seasonLabel.snp.right).offset(4)
            make.right.equalToSuperview().inset(24)
        }
        screenshotLabel.snp.makeConstraints { make in
            make.top.equalTo(seasonLabel.snp.bottom).offset(32)
            make.left.equalToSuperview().inset(24)
            //make.bottom.equalToSuperview()
        }
        screenshotCollectionView.dataSource = self
        screenshotCollectionView.delegate = self
        screenshotCollectionView.snp.makeConstraints { make in
            make.top.equalTo(screenshotLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
            make.height.equalTo(112)
        }
        sameLabel.snp.makeConstraints { make in
            make.top.equalTo(screenshotCollectionView.snp.bottom).offset(32)
            make.left.right.equalToSuperview().inset(24)
        }
        allButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(24)
            make.centerY.equalTo(sameLabel)
        }
        sameCollectionView.dataSource = self
        sameCollectionView.delegate = self
        sameCollectionView.snp.makeConstraints { make in
            make.top.equalTo(sameLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
            make.height.equalTo(224)
            make.bottom.equalToSuperview().inset(32)
        }
    }
    //MARK: - localizeLanguage
    func localizeLanguage() {
        favoriteButtonLabel.text = "ADD_FAVORITE".localized()
        sendButtonLabel.text = "SHARE".localized()
        fullDescrButton.setTitle("DETAILS".localized(), for: .normal)
        directorLabel.text = "DIRECTOR".localized()
        producerLabel.text = "PRODUCER".localized()
        seasonLabel.text = "SECTIONS".localized()
        screenshotLabel.text = "SCREENSHOTS".localized()
        sameLabel.text = "SIMILAR_SERIES".localized()
        allButton.setTitle("ALL".localized(), for: .normal)
        let seasonText = "SEASON".localized()
        let seriesText = "SERIES".localized()
        seasonButton.setTitle("\(movie.seasonCount) \(seasonText) \(movie.seriesCount) \(seriesText)", for: .normal)
    }
    //MARK: - setData
    func setData() {
        posterImage.sd_setImage(with: URL(string: movie.poster_link))
        titleLabel.text = movie.name
        subTitleLabel.text = "\(movie.year) • \(movie.genres.first?.name ?? "")"
        descriptionLabel.text = movie.description
        directorNameLabel.text = movie.director
        producerNameLabel.text = movie.producer
        
        descriptionLabel.numberOfLines = 4
        if descriptionLabel.maxNumberOfLines < 5 {
            fullDescrButton.isHidden = true
            //descriptionGradientView.isHidden = true
        }
        if movie.movieType == "MOVIE" {
            seasonLabel.isHidden = true
            seasonButton.isHidden = true
            
            screenshotLabel.snp.remakeConstraints { make in
                make.left.equalToSuperview().inset(24)
                make.top.equalTo(lineView2.snp.bottom).offset(24)
            }
        } else {
            seasonButton.setTitle("\(movie.seasonCount) sezon \(movie.seriesCount) seria", for: .normal)
        }
        
        if movie.favorite {
            favoriteButton.setImage(UIImage(named: "FavoriteForMovie2"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "FavoriteForMovie"), for: .normal)
        }
    }
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
    
    func decriptionNumber() {
        if descriptionLabel.numberOfLines > 4 {
            descriptionLabel.numberOfLines = 4
        }
        if descriptionLabel.maxNumberOfLines < 4 {
            fullDescrButton.isHidden = true
            descriptionGradientView.isHidden = true
            directorLabel.snp.remakeConstraints { make in
                make.top.equalTo(descriptionLabel.snp.bottom).offset(24)
                make.left.equalToSuperview().inset(24)
            }
        }else {
            fullDescrButton.isHidden = false
            descriptionGradientView.isHidden = false
        }
    }
    @IBAction func showFullDescription(_ sender: Any) {
        if descriptionLabel.numberOfLines == 4 {
            //pokazat
            descriptionLabel.numberOfLines = 0
            fullDescrButton.setTitle("HIDE".localized(), for: .normal)
            descriptionGradientView.isHidden = true
        } else {
            //skryt
            descriptionLabel.numberOfLines = 4
            fullDescrButton.setTitle("DETAILS".localized(), for: .normal)
            descriptionGradientView.isHidden = false
        }
    }
    
    @objc func playMovie() {
        if movie.movieType == "MOVIE" {
            let playerVC = PlayerViewController()
            
            playerVC.video_link = movie.video_link
            
            navigationController?.show(playerVC, sender: self)
            navigationItem.title = ""
        } else {
            let seasonsVC = SeasonsSeriesViewController()
            
            seasonsVC.movie = movie
            
            navigationController?.show(seasonsVC, sender: self)
            navigationItem.title = ""
        }
    }
    
    @objc func allButtonTapped(_ sender: UIButton) {
        let categoryVC = CategoryViewController()
        navigationController?.pushViewController(categoryVC, animated: true)
    }
    
    @objc func shareMovie() {
        let text = "\(movie.name) \n\(movie.description)"
        let image = posterImage.image
        let shareAll = [text, image!] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    //MARK: - addToFavorite
    @objc func addToFavorite() {
        var method = HTTPMethod.post
        if movie.favorite {
            method = .delete
        }
        
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(Storage.sharedInstance.accessToken)"]
        
        let parameters = ["movieId": movie.id] as [String : Any]
        
        AF.request(Urls.FAVORITES_URL, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseData { response in
            
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 || response.response?.statusCode == 201 {
                //                let json = JSON(response.data!)
                //                print("JSON: \(json)")
                
                self.movie.favorite.toggle()
                
                self.setData()
                
            } else {
                var ErrorString = "CONNECTION_ERROR".localized()
                if let sCode = response.response?.statusCode {
                    ErrorString = ErrorString + " \(sCode)"
                }
                ErrorString = ErrorString + " \(resultString)"
                SVProgressHUD.showError(withStatus: "\(ErrorString)")
            }
        }
    }
    //MARK: - downloadSame
    func downloadSame() {
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        
        AF.request(Urls.GET_SIMILAR + String(movie.id), method: .get, headers: headers).responseData { response in
            
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                print("JSON: \(json)")
                
                if let array = json.array {
                    for item in array {
                        let movie = Movie(json: item)
                        self.sameMovies.append(movie)
                    }
                    self.sameCollectionView.reloadData()
                } else {
                    SVProgressHUD.showError(withStatus: "CONNECTION_ERROR".localized())
                }
            } else {
                var ErrorString = "CONNECTION_ERROR".localized()
                if let sCode = response.response?.statusCode {
                    ErrorString = ErrorString + " \(sCode)"
                }
                ErrorString = ErrorString + " \(resultString)"
                SVProgressHUD.showError(withStatus: "\(ErrorString)")
            }
        }
    }
}
//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension MovieInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.sameCollectionView {
            return sameMovies.count
        }
        return movie.screenshots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.sameCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SameCell", for: indexPath) as! SameCollectionViewCell
            
            cell.posterImage.sd_setImage(with: URL(string: sameMovies[indexPath.row].poster_link), placeholderImage: nil)
            cell.titleLabel.text = sameMovies[indexPath.row].name
            
            if let genrename = sameMovies[indexPath.row].genres.first {
                cell.categoryLabel.text = genrename.name
            } else {
                cell.titleLabel.text = ""
            }
            return cell
        }
        let cell = screenshotCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieInfoCollectionCell
        cell.screenshotImage.sd_setImage(with: URL(string: movie.screenshots[indexPath.row].link))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.sameCollectionView {
            let movieinfoVC = MovieInfoViewController()
            movieinfoVC.movie  = sameMovies[indexPath.row]
            navigationItem.title = ""
            navigationController?.show(movieinfoVC, sender: self)
        }
    }
    
}
