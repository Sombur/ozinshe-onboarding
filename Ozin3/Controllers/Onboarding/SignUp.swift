//
//  SignUp.swift
//  Ozin3
//
//  Created by Самал Буранбаева on 24.01.2024.
//

import UIKit
import SVProgressHUD
import Alamofire
import SwiftyJSON
import Localize_Swift


class SignUp: UIViewController, UITextFieldDelegate {
    
    let label1 = {
        let label = UILabel()
        label.text = "Тіркелу".localized()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "TextBlack")
        
        return label
    }()
    
    let label2 = {
        let label = UILabel()
        label.text = "Деректерді толтырыңыз".localized()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        label.textColor = UIColor(named: "TextGray")
        
        return label
    }()
    
    let label3 = {
        let label = UILabel()
        label.text = "Email"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "TextBlack")
        
        return label
    }()
    
    let emailTextField = {
        let tf = TextFieldWithPadding()
        tf.placeholder = "@gmail.com"
        tf.textColor = UIColor(named: "TextBlack")
        tf.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        tf.layer.cornerRadius = 12
        tf.layer.borderWidth = 1.0
        tf.layer.borderColor = UIColor(named: "BorderGray")?.cgColor
        tf.keyboardType = .emailAddress
        tf.textContentType = .emailAddress
        tf.autocapitalizationType = .none
        tf.addTarget(self, action: #selector(editingDidbegin), for: .editingDidBegin)
        tf.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
        
        return tf
    }()
    
    let emailImage = {
        let image = UIImageView()
        image.image = UIImage(named: "eMail")
        
        return image
    }()
    
    let label4 = {
        let label = UILabel()
        label.text = "Құпия сөз".localized()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "TextBlack")
        
        return label
    }()
    
    let passwordTextField1 = {
        let tf = TextFieldWithPadding()
        tf.placeholder = "Сіздің құпия сөзіңіз".localized()
        tf.textColor = UIColor(named: "TextBlack")
        tf.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        tf.layer.cornerRadius = 12
        tf.layer.borderWidth = 1.00
        tf.layer.borderColor = UIColor(named: "BorderGray")?.cgColor
        //tf.textContentType = .password
        tf.autocapitalizationType = .none
        tf.isSecureTextEntry = true
        tf.addTarget(self, action: #selector(editingDidbegin), for: .editingDidBegin)
        tf.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
        
        return tf
    }()
    
    let passwordImage1 = {
        let image = UIImageView()
        image.image = UIImage(named: "Password")
        
        return image
    }()
    
    let showButton1 = {
        let button = UIButton()
        button.setImage(UIImage(named: "Show"), for: .normal)
        button.addTarget(self, action: #selector(showPassword1), for: .touchUpInside)
        
        return button
    }()
    
    let label5 = {
        let label = UILabel()
        label.text = "Құпия сөзді қайталаңыз".localized()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "TextBlack")
        
        return label
    }()
    
    let passwordTextField2 = {
        let tf = TextFieldWithPadding()
        tf.placeholder = "Сіздің құпия сөзіңіз".localized()
        tf.textColor = UIColor(named: "TextBlack")
        tf.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        tf.layer.cornerRadius = 12
        tf.layer.borderWidth = 1.00
        tf.layer.borderColor = UIColor(named: "BorderGray")?.cgColor
        //tf.textContentType = .password
        tf.autocapitalizationType = .none
        tf.isSecureTextEntry = true
        tf.addTarget(self, action: #selector(editingDidbegin), for: .editingDidBegin)
        tf.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
        
        return tf
    }()
    
    let passwordImage2 = {
        let image = UIImageView()
        image.image = UIImage(named: "Password")
        
        return image
    }()
    
    
    let showButton2 = {
        let button = UIButton()
        button.setImage(UIImage(named: "Show"), for: .normal)
        button.addTarget(self, action: #selector(showPassword2), for: .touchUpInside)
        
        return button
    }()
    
    let signUpButton = {
        let button = UIButton()
        button.setTitle("Тіркелу".localized(), for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.backgroundColor = UIColor(named: "DarkPurple")
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(autorization), for: .touchUpInside)
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "VCColor")
        SetupUI()
        emailTextField.delegate = self
        passwordTextField1.delegate = self
        passwordTextField2.delegate = self
    }
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        
    }
    func SetupUI() {
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(emailTextField)
        view.addSubview(emailImage)
        view.addSubview(label4)
        view.addSubview(passwordTextField1)
        view.addSubview(passwordImage1)
        view.addSubview(showButton1)
        view.addSubview(label5)
        view.addSubview(passwordTextField2)
        view.addSubview(passwordImage2)
        view.addSubview(showButton2)
        //view.addSubview(errorLabel)
        view.addSubview(signUpButton)
        
        label1.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(16)
            make.left.equalToSuperview().inset(24)
        }
        label2.snp.makeConstraints { make in
            make.top.equalTo(label1.snp.bottom)
            make.left.equalToSuperview().inset(24)
        }
        label3.snp.makeConstraints { make in
            make.top.equalTo(label2.snp.bottom).offset(32)
            make.left.equalToSuperview().inset(24)
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(label3.snp.bottom).offset(4)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        emailImage.snp.makeConstraints { make in
            make.centerY.equalTo(emailTextField)
            make.left.equalTo(emailTextField).inset(16)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        label4.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(16)
            make.left.equalToSuperview().inset(24)
        }
        passwordTextField1.snp.makeConstraints { make in
            make.top.equalTo(label4.snp.bottom).offset(4)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        passwordImage1.snp.makeConstraints { make in
            make.centerY.equalTo(passwordTextField1)
            make.left.equalTo(passwordTextField1).inset(16)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        showButton1.snp.makeConstraints { make in
            make.centerY.equalTo(passwordTextField1)
            make.right.equalTo(passwordTextField1).inset(16)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        label5.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField1.snp.bottom).offset(16)
            make.left.equalToSuperview().inset(24)
        }
        passwordTextField2.snp.makeConstraints { make in
            make.top.equalTo(label5.snp.bottom).offset(4)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        passwordImage2.snp.makeConstraints { make in
            make.centerY.equalTo(passwordTextField2)
            make.left.equalTo(passwordTextField2).inset(16)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        showButton2.snp.makeConstraints { make in
            make.centerY.equalTo(passwordTextField2)
            make.right.equalTo(passwordTextField2).inset(16)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField2.snp.bottom).offset(40)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
    }
    @objc func editingDidbegin(_ sender: TextFieldWithPadding) {
        //errorLabel.text = ""
        sender.layer.borderColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1.00).cgColor
    }
    @objc func editingDidEnd(_ sender: TextFieldWithPadding) {
        sender.layer.borderColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1.00).cgColor
    }
    @objc func showPassword1(_ sender: Any) {
        showPassword(for: passwordTextField1)
    }
    @objc func showPassword2(_ sender: Any) {
        showPassword(for: passwordTextField2)
    }
    func showPassword(for textField: TextFieldWithPadding) {
        textField.isSecureTextEntry.toggle()
        if  !textField.isSecureTextEntry {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.hidePassword(for: textField)
            }
        }
    }
    func hidePassword(for textField: TextFieldWithPadding){
        textField.isSecureTextEntry = true
    }
    func startApp() {
        let signIn = SignIn()
        navigationController?.show(signIn, sender: self)
    }
    @objc func autorization() {
        let email = emailTextField.text!
        let password1 = passwordTextField1.text!
        let password2 = passwordTextField2.text!
        
        if email.isEmpty || password1.isEmpty || password2.isEmpty {
            SVProgressHUD.showError(withStatus: "Все поля дожны быть заполнены!".localized())
            return
        }
        if password1 != password2 {
            SVProgressHUD.showError(withStatus: "Пароли должны совпадать!".localized())
            return
        }
        
        SVProgressHUD.show()
        let parameters = ["email": email, "password": password1 ]
        
        AF.request(Urls.SIGN_UP_URL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData {
            response in
            
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
        if response.response?.statusCode == 200 {
            let json = JSON(response.data!)
            print("JSON: \(json)")
            
            if let token = json["accessToken"].string {
                Storage.sharedInstance.accessToken = token
                UserDefaults.standard.set(token, forKey: "accessToken")
                self.startApp()
            } else {
                SVProgressHUD.showError(withStatus: "CONNECTION_ERROR")
            }
        } else {
            if response.response?.statusCode == 400 {
                self.label3.text = "Мұндай email-ы бар пайдаланушы тіркелген".localized()
            } else {
                var ErrorString = "CONNECTION_ERROR"
                if let sCode = response.response?.statusCode {
                    ErrorString = ErrorString + " \(sCode)"
                }
                ErrorString = ErrorString + " \(resultString)"
                SVProgressHUD.showError(withStatus: "\(ErrorString)")
            }
        }
    }
        
    }
    
}
