//
//  LogoutVC.swift
//  Ozin3
//
//  Created by Самал Буранбаева on 26.01.2024.
//

import SnapKit

class LogoutVC: UIViewController, UIGestureRecognizerDelegate {
    
    let blurEffect = UIBlurEffect(style: .light)
    let blurView = UIVisualEffectView(effect: nil)
    
    let backgraund = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "ViewColor2")
        view.layer.cornerRadius = 32
        
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
        label.text = "Шығу"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "TextBlack")
        
        return label
    }()
    
    let label2 = {
        let label = UILabel()
        label.text = "Сіз шынымен аккаунтыныздан "
        label.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        label.textColor = UIColor(named: "TextGray4")
        
        return label
    }()
    
    let yesButton = {
        let button = UIButton()
        button.setTitle("Иә, шығу", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.backgroundColor = UIColor(named: "DarkPurple")
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(logout), for: .touchUpInside)
        
        return button
    }()
    
    let noButton = {
        let button = UIButton()
        button.setTitle("Жоқ", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.setTitleColor(UIColor(named: "DarkPurple"), for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localizeLanguage()
        setupUI()
    }
    
    func localizeLanguage() {
        
        label1.text = "EXIT".localized()
        label2.text = "CONFIRM_EXIT_FROM_ACCOUNT".localized()
        yesButton.setTitle("YES_EXIT".localized(), for: .normal)
        noButton.setTitle("NO".localized(), for: .normal)
    }
    
    func setupUI() {
        
        blurView.effect = blurEffect
        blurView.frame = view.bounds
        blurView.alpha = 0.8
        view.addSubview(blurView)
        
        view.addSubview(backgraund)
        backgraund.addSubview(line)
        backgraund.addSubview(label1)
        backgraund.addSubview(label2)
        backgraund.addSubview(yesButton)
        backgraund.addSubview(noButton)
        
        backgraund.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(303)
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
        label2.snp.makeConstraints { make in
            make.top.equalTo(label1.snp.bottom).offset(8)
            make.left.equalToSuperview().inset(24)
        }
        yesButton.snp.makeConstraints { make in
            make.top.equalTo(label2.snp.bottom).offset(32)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        noButton.snp.makeConstraints { make in
            make.top.equalTo(yesButton.snp.bottom).offset(8)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: backgraund))! {
            return false
        }
        return true
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logout(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "accessToken")
        
        let rootVC = UINavigationController(rootViewController: OnboardingVC())
        
        view.window?.rootViewController = rootVC
        view.window?.makeKeyAndVisible()
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismissView()
    }
}




