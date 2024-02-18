//
//  LanguageVC.swift
//  Ozin3
//
//  Created by Самал Буранбаева on 28.01.2024.
//

import UIKit
import SnapKit
import Localize_Swift

protocol LanguageProtocol {
    func languageDidChange()
}

class LanguageVC: UIViewController, UIGestureRecognizerDelegate {
    
    
    var delegate: LanguageProtocol?
    
    let languageArray = [["English", "en"], ["Қазақша", "kk"], ["Русский", "ru"]]
    
    let blurEffect = UIBlurEffect(style: .light)
    let blurView = UIVisualEffectView(effect: nil)
    
    let backgraund = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "BackgraundColor")
        view.layer.cornerRadius = 32
        view.clipsToBounds = true
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        return view
    }()
    
    let line = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "ViewColor")
        view.layer.cornerRadius = 2.5
        
        return view
    }()
    
    let label1 = {
        let label = UILabel()
        label.text = "Тіл"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "TextBlack")
        
        return label
    }()
    
    let tableView = {
        let table = UITableView()
        table.register(LanguageCell.self, forCellReuseIdentifier: "Cell")
        
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        SetupUI()
        
    }
    func SetupUI() {
        blurView.effect = blurEffect
        blurView.frame = view.bounds
        blurView.alpha = 0.8
        view.addSubview(blurView)
        
        view.addSubview(backgraund)
        backgraund.addSubview(line)
        backgraund.addSubview(label1)
        backgraund.addSubview(tableView)
        
        backgraund.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(350)
        }
        line.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(21)
            make.centerX.equalTo(backgraund)
            make.height.equalTo(5)
            make.width.equalTo(64)
        }
        label1.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(58)
            make.left.equalToSuperview().inset(24)
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.snp.makeConstraints { make in
            make.top.equalTo(label1.snp.bottom).offset(32)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(32)
        }
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        tap.delegate = self
        view.addGestureRecognizer(tap)
        
    }
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: backgraund))! {
            return false
        }
        return true
        
    }
    
    }
extension LanguageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! LanguageCell 
        cell.label1.text = languageArray[indexPath.row][0]
        if Localize.currentLanguage() == languageArray[indexPath.row][1] {
            cell.image1.image = UIImage(named: "Check")
        } else {
            cell.image1.image = nil
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Localize.setCurrentLanguage(languageArray[indexPath.row][1])
        delegate?.languageDidChange()
        dismiss(animated: true, completion: nil)
    }
    
}
