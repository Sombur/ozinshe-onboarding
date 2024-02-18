//
//  ChangePasswordVC.swift
//  Ozin3
//
//  Created by Самал Буранбаева on 28.01.2024.
//

import SnapKit
import Alamofire
import SVProgressHUD
import SwiftyJSON


class ChangePasswordVC: UIViewController {
    
    let passwordLabel = {
        let label = UILabel()
        label.text = "Password"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "TextBlack")
        
        return label
    }()
    
    let passwordTextField = {
        let tf = TextFieldWithPadding()
        tf.placeholder = "Сіздің құпия сөзіңіз"
        tf.textColor = UIColor(named: "TextGray")
        tf.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        tf.layer.cornerRadius = 12
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor(named: "BorderGray")?.cgColor
        tf.textContentType = .password
        tf.autocapitalizationType = .none
        tf.isSecureTextEntry = true
        tf.addTarget(self, action: #selector(editingDidbegin), for: .editingDidBegin)
        tf.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
        
        return tf
    }()
    
    let image1 = {
        let image = UIImageView()
        image.image = UIImage(named: "Password")
        
        return image
    }()
    
    let button1 = {
        let button = UIButton()
        button.setImage(UIImage(named: "Show"), for: .normal)
        button.addTarget(self, action: #selector(showPassword1), for: .touchUpInside)
        
        return button
    }()
    
    let passwordLabel2 = {
        let label = UILabel()
        label.text = "Құпия сөзді қайталаңыз"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "TextBlack")
        
        return label
    }()
    
    let passwordTextField2 = {
        let tf = TextFieldWithPadding()
        tf.placeholder = "Сіздің құпия сөзіңіз"
        tf.textColor = UIColor(named: "TextGray")
        tf.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        tf.layer.cornerRadius = 12
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor(named: "BorderGray")?.cgColor
        tf.textContentType = .password
        tf.autocapitalizationType = .none
        tf.isSecureTextEntry = true
        tf.addTarget(self, action: #selector(editingDidbegin), for: .editingDidBegin)
        tf.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
        
        return tf
    }()
    
    let image2 = {
        let image = UIImageView()
        image.image = UIImage(named: "Password")
        
        return image
    }()
    
    let button2 = {
        let button = UIButton()
        button.setImage(UIImage(named: "Show"), for: .normal)
        button.addTarget(self, action: #selector(showPassword2), for: .touchUpInside)
        
        return button
    }()
    
    let saveButton = {
        let button = UIButton()
        button.setTitle("Өзгерістерді сақтау", for: .normal)
        button.backgroundColor = UIColor(named: "DarkPurple")
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font =  UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(saveTouched), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "VCColor")
        SetupUI()
    }
    func SetupUI() {
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(image1)
        view.addSubview(button1)
        view.addSubview(passwordLabel2)
        view.addSubview(passwordTextField2)
        view.addSubview(image2)
        view.addSubview(button2)
        view.addSubview(saveButton)
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(24)
            make.left.equalToSuperview().inset(24)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(4)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        image1.snp.makeConstraints { make in
            make.centerY.equalTo(passwordTextField)
            make.left.equalTo(passwordTextField).offset(16)
        }
        button1.snp.makeConstraints { make in
            make.centerY.equalTo(passwordTextField)
            make.right.equalTo(passwordTextField).inset(16)
        }
        passwordLabel2.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(24)
            make.left.equalToSuperview().inset(24)
        }
        passwordTextField2.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel2.snp.bottom).offset(4)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        image2.snp.makeConstraints { make in
            make.centerY.equalTo(passwordTextField2)
            make.left.equalTo(passwordTextField).offset(16)
        }
        button2.snp.makeConstraints { make in
            make.centerY.equalTo(passwordTextField2)
            make.right.equalTo(passwordTextField2).inset(16)
        }
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(24)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
    }
    @objc func editingDidbegin(_ sender: TextFieldWithPadding) {
        sender.layer.borderColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1.00).cgColor
    }
    @objc func editingDidEnd(_ sender: TextFieldWithPadding) {
        sender.layer.borderColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1.00).cgColor
    }
    @objc func showPassword1(_ sender: Any) {
        showPassword(for: passwordTextField)
    }
    @objc func showPassword2(_ sender: Any) {
        showPassword(for: passwordTextField2)
    }
    func showPassword(for textField: TextFieldWithPadding) {
        textField.isSecureTextEntry.toggle()
        if  !textField.isSecureTextEntry {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.hidePassword(for: textField)
            }
        }
    }
    func hidePassword(for textField: TextFieldWithPadding ){
        textField.isSecureTextEntry = true
    }
    @IBAction func saveTouched(_ sender: Any) {
        let password1 = passwordTextField.text!
        let password2 = passwordTextField2.text!
        
        // Валидация
        if password1 != password2 {
            SVProgressHUD.showError(withStatus: "Пароли должны совпадать!")
            return
        }
        
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        
        let parameters = [
            "password": password1
        ]
        
        AF.request(Urls.CHANGE_PASS_URL, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseData { response in
            SVProgressHUD.dismiss()
            
            if response.response?.statusCode == 200 {
                self.navigationController?.popViewController(animated: true)
            } else {
                var resultString = ""
                if let data = response.data {
                    resultString = String(data: data, encoding: .utf8)!
                }
                
                SVProgressHUD.showError(withStatus: resultString)
            }
        }
    }
    
}
