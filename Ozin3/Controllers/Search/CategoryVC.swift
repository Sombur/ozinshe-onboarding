//
//  CategoryVC.swift
//  Ozin3
//
//  Created by Самал Буранбаева on 25.02.2024.
//

import UIKit
import Alamofire
import SVProgressHUD
import SwiftyJSON

class CategoryVC: UIViewController {
    
    var categoryId = 0
    var categoryString: String = ""
    var categoryName = ""
    
    var movie: [Movie] = []
    
    let tableView = {
        let tv = UITableView()
        tv.register(MovieTableVieCell.self, forCellReuseIdentifier: "Cell")
        tv.separatorStyle = .none
        tv.backgroundColor = UIColor(named: "BackgraundColor")
        
        return tv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgraundColor")
        self.title = categoryName
        setupUI()
        downloadMovies()
    }
    
    func setupUI() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.self.safeAreaLayoutGuide)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(view.self.safeAreaLayoutGuide)
        }
    }
    
    func downloadMovies() {
        let headers: HTTPHeaders = ["Authorization": "Bearer \(Storage.sharedInstance.accessToken)"]
        
        let parameters = ["categoryId": categoryId]
        
        SVProgressHUD.show()
        
        AF.request(Urls.MOVIES_BY_CATEGORY_URL, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseData { response in
            SVProgressHUD.dismiss()
            
            if response.response?.statusCode == 200 {
                // Success
                let json = JSON(response.data!)
                
                if let items = json["content"].array {
                    
                    for item in items {
                        let movie = Movie(json: item)
                        
                        self.movie.append(movie)
                    }
                    self.tableView.reloadData()
                }
            } else {
                // Error
                var resultString = ""
                
                if let data = response.data {
                    resultString = String(data: data, encoding: .utf8)!
                }
                
                SVProgressHUD.showError(withStatus: resultString)
            }
        }
    }
}
extension CategoryVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MovieTableVieCell
        cell.setData(movie: movie[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 152
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieInfoVC = MovieInfoVC()
        movieInfoVC.movie = movie[indexPath.row]
        
        navigationController?.pushViewController(movieInfoVC, animated: true)
        
    }
    
}


