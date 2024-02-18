//
//  HomeVC.swift
//  Ozin3
//
//  Created by Самал Буранбаева on 24.01.2024.
//

import SnapKit
import SVProgressHUD
import Alamofire
import SwiftyJSON
import Localize_Swift

class MainPageVC: UIViewController, MovieProtocol {
    var mainMovies: [MainMovies] = []
    
    let tableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.allowsSelection = true
        tv.showsVerticalScrollIndicator = false
        tv.showsHorizontalScrollIndicator = false
        tv.backgroundColor = .cyan   //UIColor(named: "TablVColor")
        
        tv.register(MainBannerTVC.self, forCellReuseIdentifier: "MainBannerCell")
        tv.register(HistoryTVC.self, forCellReuseIdentifier: "HistoryCell")
        tv.register(GenreTVC.self, forCellReuseIdentifier: "GenreCell")
        tv.register(MainTVC.self, forCellReuseIdentifier: "MainCell")
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgraundColor")
        addLogoItem()
        setupUI()
        downloadBanners()
        
    }
    func addLogoItem() {
        let image = UIImage(named: "mainLogo")
        let logoIV = UIImageView(image: image)
        let imageItem = UIBarButtonItem.init(customView: logoIV)
        navigationItem.leftBarButtonItem = imageItem
    }
    func setupUI() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    func downloadBanners() {
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(Storage.sharedInstance.accessToken)"]
        
        AF.request(Urls.MAIN_BANNERS_URL, method: .get, headers: headers).responseData { response in
            
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
                    let movie = MainMovies()
                    movie.cellType = .mainBanner
                    for item in array {
                        let bannerMovie = BannerMovie(json: item)
                        movie.bannerMovie.append(bannerMovie)
                    }
                    self.mainMovies.append(movie)
                    self.tableView.reloadData()
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
      //      self.downloadUserHistory()
        }
    }
}
extension MainPageVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainMovies.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mainMovie = mainMovies[indexPath.row]
        
       // if mainMovie.cellType == .mainBanner {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainBannerCell", for: indexPath) as! MainBannerTVC
            
        cell.setData(mainMovie: mainMovie.bannerMovie)
            cell.delegate = self
            return cell
//        }
//        if mainMovie.cellType == .userHistory {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryTVC
//            
//            return cell
//        }
//                let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell") as! MainTVC
//        
//                cell.setData(movies: mainMovie)
//                    cell.delegate = self
        
  //              return cell
           }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 272
        }
        func movieDidSelect(movie: Movie) {
            let movieInfoVC = MovieInfoVC()
            movieInfoVC.movie = movie
            navigationController?.pushViewController(movieInfoVC, animated: true)
        }
    }
