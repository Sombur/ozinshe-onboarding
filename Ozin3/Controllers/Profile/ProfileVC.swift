//
//  ProfileVC.swift
//  Ozin3
//
//  Created by Самал Буранбаева on 24.01.2024.
//

import SnapKit
import Localize_Swift

class ProfileVC: UIViewController, LanguageProtocol {
    
    let logoutButton = {
        let button = UIBarButtonItem()
        button.image = UIImage(named: "Logout")
        button.tintColor = .red
        button.action = #selector(logout)
        
        return button
    }()
    
    let avatarImage = {
        let image = UIImageView()
        image.image = UIImage(named: "Avatar")
        
        return image
    }()
    
    let profileLabel = {
        let label = UILabel()
        label.text = "Менің профилім".localized()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "TextBlack")
        
        return label
    }()
    
    let emailLabel = {
        let label = UILabel()
        label.text = "ali@gmail.com"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(named: "TextGray")
        
        return label
    }()
    
    let subView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "BackgraundColor")
        
        return view
    }()
    
    let personalButton = {
        let button = UIButton()
        button.setTitle("Жеке деректер".localized(), for: .normal)
        button.setTitleColor(UIColor(named: "TextBlack"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(openPersonalData), for: .touchUpInside)
        
        return button
    }()
    
    let treatmentLabel = {
        let label = UILabel()
        label.text = "Өңдеу".localized()
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        label.textColor = UIColor(named: "TextGray")
        
        return label
    }()
    
    let chevron1 = {
        let image = UIImageView()
        image.image = UIImage(named: "Chevron")
        
        return image
    }()
    
    let line1 = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "LineView")
        
        return view
    }()
    
    let changePasswordButton = {
        let button = UIButton()
        button.setTitle("Құпия сөзді өзгерту".localized(), for: .normal)
        button.setTitleColor(UIColor(named: "TextBlack"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(openChangePassword), for: .touchUpInside)
        
        return button
    }()
    
    let chevron2 = {
        let image = UIImageView()
        image.image = UIImage(named: "Chevron")
        
        return image
    }()
    
    let line2 = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "LineView")
        
        return view
    }()
    
    let languageButton = {
        let button = UIButton()
        button.setTitle("Тіл".localized(), for: .normal)
        button.setTitleColor(UIColor(named: "TextBlack"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(openLanguageVC), for: .touchUpInside)
        
        return button
    }()
    
    let languageLabel = {
        let label = UILabel()
        label.text = "Қазақша".localized()
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        label.textColor = UIColor(named: "TextGray")
        
        return label
    }()
    
    let chevron3 = {
        let image = UIImageView()
        image.image = UIImage(named: "Chevron")
        
        return image
    }()
    
    let line3 = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "LineView")
        
        return view
    }()
    
    let conditionsButton = {
        let button = UIButton()
        button.setTitle("Ережелер мен шарттар".localized(), for: .normal)
        button.setTitleColor(UIColor(named: "TextBlack"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        button.contentHorizontalAlignment = .left
        
        return button
    }()
    
    let chevron4 = {
        let image = UIImageView()
        image.image = UIImage(named: "Chevron")
        
        return image
    }()
    
    let line4 = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "LineView")
        
        return view
    }()
    
    let notificationButton = {
        let button = UIButton()
        button.setTitle("Хабарландырулар".localized(), for: .normal)
        button.setTitleColor(UIColor(named: "TextBlack"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        button.contentHorizontalAlignment = .left
        
        return button
    }()
    
    let switch1 = {
        let switc = UISwitch()
        switc.onTintColor = UIColor(named: "LightPurple")
        
        return switc
    }()
    
    let line5 = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "LineView")
        
        return view
    }()
    
    let darkModeButton = {
        let button = UIButton()
        button.setTitle("Қараңғы режим".localized(), for: .normal)
        button.setTitleColor(UIColor(named: "TextBlack"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        button.contentHorizontalAlignment = .left
        
        return button
    }()
    let switch2 = {
        let switc = UISwitch()
        switc.onTintColor = UIColor(named: "LightPurple")
        switc.addTarget(self, action: #selector(darkMode), for: .touchUpInside)
        
        return switc
    }()
    let line6 = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "LineView")
        
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "VCColor")
        
        setupUI()
        configureViews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    func setupUI() {
        navigationItem.rightBarButtonItem = logoutButton
        logoutButton.target = self
        
        view.addSubview(avatarImage)
        view.addSubview(profileLabel)
        view.addSubview(emailLabel)
        view.addSubview(subView)
        subView.addSubview(personalButton)
        subView.addSubview(treatmentLabel)
        subView.addSubview(chevron1)
        subView.addSubview(line1)
        subView.addSubview(changePasswordButton)
        subView.addSubview(chevron2)
        subView.addSubview(line2)
        subView.addSubview(languageButton)
        subView.addSubview(languageLabel)
        subView.addSubview(chevron3)
        subView.addSubview(line3)
        subView.addSubview(conditionsButton)
        subView.addSubview(chevron4)
        subView.addSubview(line4)
        subView.addSubview(notificationButton)
        subView.addSubview(switch1)
        subView.addSubview(line5)
        subView.addSubview(darkModeButton)
        subView.addSubview(switch2)
        subView.addSubview(line6)
        
        avatarImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(24)
            make.centerX.equalToSuperview()
        }
        profileLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImage.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(profileLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        subView.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(24)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        personalButton.snp.makeConstraints {make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        treatmentLabel.snp.makeConstraints { make in
            make.centerY.equalTo(personalButton)
            make.right.equalTo(personalButton).inset(24)
        }
        chevron1.snp.makeConstraints { make in
            make.centerY.equalTo(personalButton)
            make.right.equalTo(personalButton)
        }
        line1.snp.makeConstraints { make in
            make.top.equalTo(personalButton.snp.bottom)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        changePasswordButton.snp.makeConstraints { make in
            make.top.equalTo(line1.snp.bottom)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        chevron2.snp.makeConstraints { make in
            make.centerY.equalTo(changePasswordButton)
            make.right.equalTo(changePasswordButton)
        }
        line2.snp.makeConstraints { make in
            make.top.equalTo(changePasswordButton.snp.bottom)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        languageButton.snp.makeConstraints { make in
            make.top.equalTo(line2.snp.bottom)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        languageLabel.snp.makeConstraints { make in
            make.centerY.equalTo(languageButton)
            make.right.equalTo(languageButton).inset(24)
        }
        chevron3.snp.makeConstraints { make in
            make.centerY.equalTo(languageButton)
            make.right.equalTo(languageButton)
        }
        line3.snp.makeConstraints { make in
            make.top.equalTo(languageButton.snp.bottom)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        conditionsButton.snp.makeConstraints { make in
            make.top.equalTo(line3.snp.bottom)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        chevron4.snp.makeConstraints { make in
            make.centerY.equalTo(conditionsButton)
            make.right.equalTo(conditionsButton)
        }
        line4.snp.makeConstraints { make in
            make.top.equalTo(conditionsButton.snp.bottom)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        notificationButton.snp.makeConstraints { make in
            make.top.equalTo(line4.snp.bottom)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        switch1.snp.makeConstraints { make in
            make.centerY.equalTo(notificationButton)
            make.right.equalTo(notificationButton)
            make.width.equalTo(52)
            make.height.equalTo(32)
        }
        line5.snp.makeConstraints { make in
            make.top.equalTo(notificationButton.snp.bottom)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        darkModeButton.snp.makeConstraints { make in
            make.top.equalTo(line5.snp.bottom)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        switch2.snp.makeConstraints { make in
            make.centerY.equalTo(darkModeButton)
            make.right.equalTo(darkModeButton)
            make.width.equalTo(52)
            make.height.equalTo(32)
        }
        line6.snp.makeConstraints { make in
            make.top.equalTo(darkModeButton.snp.bottom)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
    }
    func configureViews() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = UIColor(named: "TextGray")
        
        profileLabel.text = "MY_PROFILE".localized()
        languageButton.setTitle("LANGUAGE".localized(), for:.normal)
        personalButton.setTitle("PERSONAL_DATA".localized(), for: .normal)
        changePasswordButton.setTitle("CHANGE_PASSWORD".localized(), for: .normal)
        notificationButton.setTitle("NOTIFICATIONS".localized(), for: .normal)
        darkModeButton.setTitle("DARK_MODE".localized(), for: .normal)
        
        
        if Localize.currentLanguage() == "ru" {
            languageLabel.text = "Русский"
            treatmentLabel.text = "Обработка данных"
        }
        if Localize.currentLanguage() == "kk" {
            languageLabel.text = "Қазақша"
            treatmentLabel.text = "Өңдеу"
            
        }
        if Localize.currentLanguage() == "en" {
            languageLabel.text = "English"
            treatmentLabel.text = "Treatment"
        }
    }
    @objc func logout() {
        let logout = LogoutVC()
        logout.modalPresentationStyle = .overFullScreen
        present(logout, animated: true)
    }
    @objc func openPersonalData() {
        let pd = PersonalVC()
        navigationController?.show(pd, sender: self)
        pd.title = "Жеке деректер"
        tabBarController?.tabBar.isHidden = true
    }
    @objc func openChangePassword() {
        let cp = ChangePasswordVC()
        navigationController?.show(cp, sender: self)
        cp.title = "Құпия сөзді өзгерту"
        tabBarController?.tabBar.isHidden = true
        
    }
    @objc func openLanguageVC() {
        let languageVC = LanguageVC()
        
        languageVC.modalPresentationStyle = .overFullScreen
        languageVC.delegate = self
        present(languageVC, animated: true, completion: nil)
    }
    func languageDidChange() {
        configureViews()
    }
    @objc func darkMode(_ sender: UISwitch) {
        //        let isDarkMode = sender.isOn
        //
        //    (UIApplication.shared.delegate as? AppDelegate)?.window?.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
        //
        //        UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
        //        print("Dark mode set to \(isDarkMode)")
        //
        //    }
        let defaults = UserDefaults.standard
        if let window = view.window {
            if sender.isOn {
                window.overrideUserInterfaceStyle = .dark
                defaults.set("Dark", forKey: "Theme")
                
            } else {
                window.overrideUserInterfaceStyle = .light
                defaults.setValue("Light", forKey: "Theme")
            }
        }
    }
}
