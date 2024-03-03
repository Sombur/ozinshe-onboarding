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


class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    let titleLabel = {
        let label = UILabel()
        label.text = "Тіркелу".localized()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "111827-FFFFFF")
        
        return label
    }()
    
    let subTitleLabel = {
        let label = UILabel()
        label.text = "Деректерді толтырыңыз".localized()
        label.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        label.textColor = UIColor(named: "6B7280-9CA3AF")
        
        return label
    }()
    
    let emailLabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "111827-FFFFFF")
        
        return label
    }()
    
    let emailTextField = {
        let tf = TextFieldWithPadding()
        tf.placeholder = "@gmail.com"
        tf.textColor = UIColor(named: "111827-FFFFFF")
        tf.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        tf.layer.cornerRadius = 12
        tf.layer.borderWidth = 1.0
        tf.layer.borderColor = UIColor(named: "E5EBF0-9CA3AF")?.cgColor
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
    
    let passwordLabel = {
        let label = UILabel()
        label.text = "Құпия сөз".localized()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "111827-FFFFFF")
        
        return label
    }()
    
    let passwordTextField1 = {
        let tf = TextFieldWithPadding()
        tf.placeholder = "Сіздің құпия сөзіңіз"
        tf.textColor = UIColor(named: "111827-FFFFFF")
        tf.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        tf.layer.cornerRadius = 12
        tf.layer.borderWidth = 1.00
        tf.layer.borderColor = UIColor(named: "E5EBF0-9CA3AF")?.cgColor
//        tf.textContentType = .none
//        tf.autocapitalizationType = .none
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
    
    let passwordLabel2 = {
        let label = UILabel()
        label.text = "Құпия сөзді қайталаңыз".localized()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "111827-FFFFFF")
        
        return label
    }()
    
    let passwordTextField2 = {
        let tf = TextFieldWithPadding()
        tf.placeholder = "Сіздің құпия сөзіңіз".localized()
        tf.textColor = UIColor(named: "111827-FFFFFF")
        tf.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        tf.layer.cornerRadius = 12
        tf.layer.borderWidth = 1.00
        tf.layer.borderColor = UIColor(named: "E5EBF0-9CA3AF")?.cgColor
//        tf.textContentType = .none
//        tf.keyboardType = .default
//        tf.autocapitalizationType = .none
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
    
    lazy var errorLabel = {
        let label = UILabel()
        //label.text = ""
        label.font = UIFont(name: "SFProDisplay-Medium", size: 14)
        label.textColor = UIColor(named: "FF402B")
        label.textAlignment = .center
        
        return label
    }()
    
    let signUpButton = {
        let button = UIButton()
        button.setTitle("Тіркелу".localized(), for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.backgroundColor = UIColor(named: "7E2DFC")
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(autorization), for: .touchUpInside)
        
        return button
    }()
    
    let accountLabel = {
        let label = UILabel()
        label.text = "Сізде аккаунт бар ма?"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        label.textColor = UIColor(named: "6B7280-FFFFFF")
        label.textAlignment = .right
        
        return label
    }()
    
    let signInButton = {
        let button = UIButton()
        button.setTitle("Кіру", for: .normal)
        button.setTitleColor(UIColor(named: "9753FO"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        button.addTarget(self, action: #selector(openSignIn), for: .touchUpInside)
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "FFFFFF-111827")
    
        localizeLanguage()
        SetupUI()
        hideKeyboardWhenTappedAround()
    }
    //MARK: - SetupUI
    func SetupUI() {
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(emailImage)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField1)
        view.addSubview(passwordImage1)
        view.addSubview(showButton1)
        view.addSubview(passwordLabel2)
        view.addSubview(passwordTextField2)
        view.addSubview(passwordImage2)
        view.addSubview(showButton2)
        view.addSubview(errorLabel)
        view.addSubview(signUpButton)
        view.addSubview(accountLabel)
        view.addSubview(signInButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(16)
            make.left.equalToSuperview().inset(24)
        }
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.equalToSuperview().inset(24)
        }
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(32)
            make.left.equalToSuperview().inset(24)
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(4)
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
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(16)
            make.left.equalToSuperview().inset(24)
        }
        passwordTextField1.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(4)
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
        passwordLabel2.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField1.snp.bottom).offset(16)
            make.left.equalToSuperview().inset(24)
        }
        passwordTextField2.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel2.snp.bottom).offset(4)
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
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField2.snp.bottom).offset(32)
            make.left.right.equalToSuperview().inset(24)
        }
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(errorLabel.snp.bottom).offset(40)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        accountLabel.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(24)
            make.left.equalToSuperview().inset(90)
        }
        signInButton.snp.makeConstraints { make in
            make.centerY.equalTo(accountLabel)
            make.left.equalTo(accountLabel.snp.right).offset(4)
        }
    }
    //MARK: - localizeLanguage
    func localizeLanguage() {
        titleLabel.text = "SIGN_UP".localized()
        subTitleLabel.text = "FILL_IN_DATA".localized()
        emailTextField.placeholder = "YOUR_EMAIL".localized()
        passwordLabel.text = "PASSWORD".localized()
        passwordTextField1.placeholder = "YOUR_PASSWORD".localized()
        passwordLabel2.text = "REPEAT_PASSWORD".localized()
        passwordTextField2.placeholder = "YOUR_PASSWORD".localized()
        signUpButton.setTitle("SIGN_UP".localized(), for: .normal)
        signInButton.setTitle("SIGN_IN".localized(), for: .normal)
        
    }
    @objc func editingDidbegin(_ sender: TextFieldWithPadding) {
        //errorLabel.text = ""
        sender.layer.borderColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1.00).cgColor
    }
    
    @objc func editingDidEnd(_ sender: TextFieldWithPadding) {
        sender.layer.borderColor = UIColor(red: 229/255, green: 245/255, blue: 240/255, alpha: 1.00).cgColor
    }
    
    @objc func showPassword1(_ sender: Any) {
        showPassword(for: passwordTextField1)
    }
    
    @objc func showPassword2(_ sender: Any) {
        showPassword(for: passwordTextField2)
    }
    
    func showPassword(for textField: TextFieldWithPadding) {
       // textField.isSecureTextEntry.toggle()
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
        let signIn = SignInViewController()
        navigationController?.show(signIn, sender: self)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func openSignIn() {
        let signIn = SignInViewController()
        navigationController?.show(signIn, sender: self)
        navigationItem.title = ""
    }
    
    @objc func autorization() {
        let email = emailTextField.text!
        let password1 = passwordTextField1.text!
        let password2 = passwordTextField2.text!
        
        if email.isEmpty || password1.isEmpty || password2.isEmpty {
            SVProgressHUD.showError(withStatus: "All_FIELDS_MUST_BE_FILLED_IN".localized())
            return
        }
        if password1 != password2 {
            SVProgressHUD.showError(withStatus: "PASS_NOT_MATCH".localized())
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
                    SVProgressHUD.showError(withStatus: "CONNECTION_ERROR".localized())
                }
            } else {
                if response.response?.statusCode == 400 {
                    self.errorLabel.text = "EMAIL_IN_USE".localized()
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
