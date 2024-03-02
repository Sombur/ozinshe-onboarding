//
//  SeasonsSeriesVC.swift
//  Ozin3
//
//  Created by Самал Буранбаева on 22.02.2024.
//

import SnapKit
import SVProgressHUD
import Alamofire
import SwiftyJSON
import SDWebImage
import Localize_Swift

class SeasonsSeriesVC: UIViewController {
    var movie = Movie()
    var seasons: [Season] = []
    var currentSeason = 0
    
    let seriasCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 24.0, left: 24.0, bottom: 8.0, right: 24.0)
        layout.itemSize = CGSize(width: 85, height: 34)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(SeasonsCVC.self, forCellWithReuseIdentifier: "SeasonsCVC")
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        
        
        return cv
    }()
    
    let seriasTableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.allowsSelection = true
        tv.showsVerticalScrollIndicator = false
        tv.showsHorizontalScrollIndicator = false
        tv.backgroundColor = .clear
        
        tv.register(SeasonsTVC.self, forCellReuseIdentifier: "SeasonsTVC")
        
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgraundColor")
        self.title = "Бөлімдер"
        setupUI()
        downloadSeasons()
    }
   
    func setupUI() {
        view.addSubview(seriasCollectionView)
        view.addSubview(seriasTableView)
        
        seriasCollectionView.delegate = self
        seriasCollectionView.dataSource = self
        seriasCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
            make.height.equalTo(74)
        }
        seriasTableView.delegate = self
        seriasTableView.dataSource = self
        seriasTableView.snp.makeConstraints { make in
            make.top.equalTo(seriasCollectionView.snp.bottom)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    func downloadSeasons() {
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(Storage.sharedInstance.accessToken)"]
        
        
        AF.request(Urls.GET_SEASONS + "\(movie.id)", method: .get, headers: headers  ) .responseData { response in
            
            SVProgressHUD.dismiss()
             var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            if response.response?.statusCode == 200 {
                //if let data = response.data {
                let json = JSON(response.data!)
                print("JSON: \(json)")
                
                
                if let array = json.array {
                    for item in array {
                        let season = Season(json: item)
                        self.seasons.append(season)
                    }
                    self.seriasCollectionView.reloadData()
                    self.seriasTableView.reloadData()
                    
                } else {
                    SVProgressHUD.showError(withStatus: "CONNECTION_ERROR".localized())
                }
            }
        }
    }
}
    // MARK: - CollectionView
    
    extension SeasonsSeriesVC: UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return seasons.count    }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeasonsCVC", for: indexPath) as! SeasonsCVC
            
            let sezonText = "SEASON".localized()
            cell.seasonLabel.text = "\(seasons[indexPath.row].number) \(sezonText)"

            if currentSeason == seasons[indexPath.row].number - 1 {
                cell.seasonLabel.textColor = UIColor(displayP3Red: 249/255, green: 250/255, blue: 251/255, alpha: 1)
                cell.view1.backgroundColor = UIColor(displayP3Red: 151/255, green: 83/255, blue: 240/255, alpha: 1)
            } else {
                cell.seasonLabel.textColor = UIColor(displayP3Red: 55/255, green: 65/255, blue: 81/255, alpha: 1)
                cell.view1.backgroundColor = UIColor(displayP3Red: 243/255, green: 244/255, blue: 246/255, alpha: 1)
            }

            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            collectionView.deselectItem(at: indexPath, animated: true)
            currentSeason = seasons[indexPath.row].number - 1
            seriasTableView.reloadData()
            seriasCollectionView.reloadData()
        }
        // MARK: - UITableView
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if seasons.count == 0 {
                return 0
            }
            return seasons[currentSeason].videos.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SeasonsTVC", for: indexPath) as! SeasonsTVC
            
            cell.posterImage.sd_setImage(with: URL(string: "https://img.youtube.com/vi/\(seasons[currentSeason].videos[indexPath.row].link)/hqdefault.jpg"))
            
            let seriesText = "SERIES".localized()
            cell.seriasLabel.text = "\(seasons[currentSeason].videos[indexPath.row].number) \(seriesText)"
            
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 240
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            
            let playerVC = PlayerVC()
            
            playerVC.video_link = seasons[currentSeason].videos[indexPath.row].link
            
            navigationController?.show(playerVC, sender: self)
        }
    }

