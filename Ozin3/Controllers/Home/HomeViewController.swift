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

class HomeViewController: UIViewController, MovieProtocol {
    
    
    var mainMovies: [MainMovies] = []
    
    let tableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.allowsSelection = true
        tv.showsVerticalScrollIndicator = false
        tv.showsHorizontalScrollIndicator = false
        tv.backgroundColor = .clear
        
        tv.register(MainBannerTableViewCell.self, forCellReuseIdentifier: "MainBannerCell")
        tv.register(HistoryTableViewController.self, forCellReuseIdentifier: "HistoryCell")
        tv.register(MainMovieTableViewController.self, forCellReuseIdentifier: "MainCell")
        tv.register(GenreAgeTableViewController.self, forCellReuseIdentifier: "GenreCell")
        
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "FFFFFF-111827")
        addLogoItem()
        setupUI()
        downloadBanners()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    func addLogoItem() {
        let image = UIImage(named: "mainLogo")
        let logoIV = UIImageView(image: image)
        let imageItem = UIBarButtonItem.init(customView: logoIV)
        navigationItem.leftBarButtonItem = imageItem
    }
    //MARK: - setupUI
    
    func setupUI() {
        navigationItem.title = " "
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
    //MARK: - downloadBanners
    
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
            self.downloadHistory()
        }
    }
    //MARK: - downloadHistory
    
    func downloadHistory() {
        let headers: HTTPHeaders = ["Authorization": "Bearer \(Storage.sharedInstance.accessToken)"]
        
        SVProgressHUD.show()
        
        AF.request(Urls.USER_HISTORY_URL, method: .get, headers: headers).responseData { response in
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                
                if let movies = json.array {
                    let historyMovies = MainMovies()
                    historyMovies.cellType = .userHistory
                    for movie in movies {
                        let movieItem = Movie(json: movie)
                        historyMovies.movies.append(movieItem)
                    }
                    if movies.count > 0 {
                        self.mainMovies.append(historyMovies)
                    }
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
            self.downloadMainMovies()
            
        }
    }
    //MARK: - downloadMainMovies
    
    func downloadMainMovies() {
        let headers: HTTPHeaders = ["Authorization": "Bearer \(Storage.sharedInstance.accessToken)"]
        
        SVProgressHUD.show()
        
        AF.request(Urls.MAIN_MOVIES_URL, method: .get, headers: headers) .responseData { response in
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                
                if let movies = json.array {
                    for mainMovieItem in movies {
                        let mainMovie = MainMovies(json: mainMovieItem)
                        self.mainMovies.append(mainMovie)
                    }
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
            self.downloadGenre()
        }
    }
    //MARK: - downloadGenre
    
    func downloadGenre() {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        
        SVProgressHUD.show()
        
        AF.request(Urls.GET_GENRES_URL, method: .get, headers: headers).responseData { response in
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                
                if let genres = json.array {
                    let genres1 = MainMovies()
                    genres1.cellType = .genre
                    for genreJson in genres {
                        let genreItem = Genre(json: genreJson)
                        genres1.genres.append(genreItem)
                    }
                    if self.mainMovies.count > 4 {
                        if self.mainMovies[1].cellType == .userHistory {
                            self.mainMovies.insert(genres1, at: 4)
                        } else {
                            self.mainMovies.insert(genres1, at: 3)
                        }
                    } else {
                        self.mainMovies.append(genres1)
                    }
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
            self.downloadAges()
        }
    }
    //MARK: - downloadAges
    
    func downloadAges() {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        
        SVProgressHUD.show()
        
        AF.request(Urls.GET_AGES_URL, method: .get, headers: headers).responseData { response in
            SVProgressHUD.dismiss()
            
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                
                if let ages = json.array {
                    let ages1 = MainMovies()
                    ages1.cellType = .ageCategory
                    
                    for ageJson in ages {
                        let ageItem = Ages(json: ageJson)
                        ages1.categoryAges.append(ageItem)
                    }
                    if self.mainMovies.count > 8 {
                        if self.mainMovies[1].cellType == .userHistory {
                            self.mainMovies.insert(ages1, at: 8)
                        } else {
                            self.mainMovies.insert(ages1, at: 7)
                        }
                    } else {
                        self.mainMovies.append(ages1)
                    }
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
        }
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainMovies.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let mainMovie = mainMovies[indexPath.row]
        
        if mainMovie.cellType == .mainBanner {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainBannerCell", for: indexPath) as! MainBannerTableViewCell
            cell.backgroundColor = .clear
            cell.setData(mainMovie: mainMovie.bannerMovie)
            cell.delegate = self
            return cell
        }
        if mainMovie.cellType == .userHistory {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryTableViewController
            cell.backgroundColor = .clear
            cell.setData(movies: mainMovie.movies)
            cell.delegate = self
            return cell
        }
        if mainMovies[indexPath.row].cellType == .genre ||
            mainMovies[indexPath.row].cellType == .ageCategory {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GenreCell") as! GenreAgeTableViewController
            cell.delegate = self
            cell.backgroundColor = .clear
            cell.setData(movies: mainMovies[indexPath.row])
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainMovieTableViewController
        cell.backgroundColor = .clear
        cell.setData(movies: mainMovie)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let mainMovie = mainMovies[indexPath.row]
        
        if mainMovie.cellType == .mainBanner {
            return 272
        }
        if mainMovie.cellType == .userHistory {
            return 228
        }
        
        if mainMovie.cellType == .genre || mainMovie.cellType == .ageCategory {
            
            return 184
            
        }
        return 288
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        if mainMovies[indexPath.row].cellType != .mainMovie {
            return
        }
        
        let categoryVC = CategoryViewController()
        categoryVC.categoryId = mainMovies[indexPath.row].categoryId
        categoryVC.categoryName = mainMovies[indexPath.row].categoryName
        navigationController?.show(categoryVC, sender: self)
    }
    //MARK: - func DidSelect
    
    func movieDidSelect(movie: Movie) {
        let movieInfoVC = MovieInfoViewController()
        movieInfoVC.movie = movie
        navigationController?.show(movieInfoVC, sender: true)
    }
    
    func ageDidSelect(id: Int, name: String) {
        let categoryVC = CategoryViewController()
        categoryVC.categoryId = id
        categoryVC.categoryName = name
        categoryVC.categoryString = "Age"
        navigationController?.pushViewController(categoryVC, animated: true)
    }
    
    func genreDidSelect(id: Int, name: String) {
        let categoryVC = CategoryViewController()
        categoryVC.categoryId = id
        categoryVC.categoryName = name
        categoryVC.categoryString = "Genre"
        navigationController?.pushViewController(categoryVC, animated: true)
    }
}
