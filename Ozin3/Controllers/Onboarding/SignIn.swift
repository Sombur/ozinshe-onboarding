//
//  SignIn.swift
//  Ozin3
//
//  Created by Самал Буранбаева on 24.01.2024.
//

import SnapKit
import Alamofire
import SVProgressHUD
import SwiftyJSON

class SignIn: UIViewController, UITextFieldDelegate {
    
    let helloLabel = {
        let label = UILabel()
        
        label.text = "Сәлем"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "TextBlack")
        
        return label
    }()
    
    let label2 = {
        let label = UILabel()
        
        label.text = "Аккаунтқа кіріңіз"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(named: "TextGray")
        
        return label
    }()
    
  let emailLabel = {
        let label = UILabel()
        
        label.text = "Email"
      label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
      label.textColor = UIColor(named: "TextBlack")
      
      return label
    }()
    
    let emailTextField = {
       let tf = TextFieldWithPadding()
        
        tf.placeholder = "Сіздің email"
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
    
    let errorLabel = {
        let label = UILabel()
        
        label.text = ""
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(named: "TextRed")
        
        return label
    }()
    
    let emailImage = {
        let image = UIImageView()
        
        image.image = UIImage(named: "eMail")
        
        return image
    }()
    
    let passwordLabel = {
        let label = UILabel()
        
        label.text = "Құпия сөз"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "TextBlack")
        
        return label
    }()
    
    let passwordTextField = {
        let tf = TextFieldWithPadding()
        
        tf.placeholder = "Сіздің құпия сөзіңіз"
        tf.textColor = UIColor(named: "TextBlack")
        tf.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        tf.layer.cornerRadius = 12
        tf.layer.borderWidth = 1.0
        tf.layer.borderColor = UIColor(named: "BorderGray")?.cgColor
        tf.textContentType = .password
        tf.autocapitalizationType = .none
        tf.isSecureTextEntry = true
        tf.addTarget(self, action: #selector(editingDidbegin), for: .editingDidBegin)
        tf.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
        
        return tf
    }()
    
    let passwordImage = {
        let image = UIImageView()
        
        image.image = UIImage(named: "Password")
        
        return image
    }()
    
    let showButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "Show"), for: .normal)
        button.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
        return button
    }()
    
    let label3 = {
        let label = UILabel()
        
        label.text = "Құпия сөзді ұмыттыңыз ба?"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        label.textColor = UIColor(named: "LightPurple")
        label.textAlignment = .right
        
        return label
    }()
     
    let startButton = {
        let button = UIButton()
        
        button.setTitle("Кіру", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor(named: "DarkPurple")
        button.addTarget(self, action: #selector(signIn), for: .touchUpInside)

        return button
    }()
    
    let label4 = {
        let label = UILabel()
        
        label.text = "Аккаунтыныз жоқ па?"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(named: "TextGray")
        label.textAlignment = .right
        
        return label
    }()
    
    let signUpButton = {
        let button = UIButton()
        
        button.setTitle("Тіркелу", for: .normal)
        button.setTitleColor(UIColor(named: "LightPurple"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        button.addTarget(self, action: #selector(openSignUp), for: .touchUpInside)
        
        return button
    }()
    
    let label5 = {
        let label = UILabel()
        
        label.text = "Немесе"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(named: "TextGray")
        label.textAlignment = .center
        
        return label
    }()
    
    let appleButton = {
        let button = UIButton(type: .system)
        
        button.setImage(UIImage(named: "Apple"), for: .normal)
        button.setTitle("Apple ID-мен тіркеліңіз", for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        button.setTitleColor(UIColor(named: "TextBlack"), for: .normal)
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(named: "BorderGray")?.cgColor
        
      return  button
    }()
    
    let googleButton = {
        let button = UIButton(type: .system)
        
        button.setImage(UIImage(named: "Google"), for: .normal)
        button.setTitle("Google-мен тіркеліңіз", for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        button.setTitleColor(UIColor(named: "TextBlack"), for: .normal)
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(named: "BorderGray")?.cgColor
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "VCColor")
        SetupUI()
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
    }
    func SetupUI() {
        view.addSubview(helloLabel)
        view.addSubview(label2)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(errorLabel)
        view.addSubview(emailImage)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordImage)
        view.addSubview(showButton)
        view.addSubview(label3)
        view.addSubview(startButton)
        view.addSubview(label4)
        view.addSubview(signUpButton)
        view.addSubview(label5)
        view.addSubview(appleButton)
        view.addSubview(googleButton)
        
        helloLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(16)
            make.left.equalToSuperview().inset(24)
        }
        label2.snp.makeConstraints { make in
            make.top.equalTo(helloLabel.snp.bottom)
            make.left.equalToSuperview().inset(24)
        }
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(label2.snp.bottom).offset(32)
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
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(16)
            make.left.equalToSuperview().inset(24)
        }
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(errorLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().inset(24)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(4)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        passwordImage.snp.makeConstraints { make in
            make.centerY.equalTo(passwordTextField)
            make.left.equalTo(passwordTextField).inset(16)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        showButton.snp.makeConstraints { make in
            make.centerY.equalTo(passwordTextField)
            make.right.equalTo(passwordTextField).inset(16)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        label3.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(17)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
        }
        startButton.snp.makeConstraints { make in
            make.top.equalTo(label3.snp.bottom).offset(40)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        label4.snp.makeConstraints { make in
            make.top.equalTo(startButton.snp.bottom).offset(24)
            make.left.equalToSuperview().inset(90)
        }
        signUpButton.snp.makeConstraints { make in
            make.centerY.equalTo(label4)
            make.left.equalTo(label4.snp.right).offset(4)
        }
        label5.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(40)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
        }
        appleButton.snp.makeConstraints { make in
            make.top.equalTo(label5.snp.bottom).offset(16)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(52)
        }
        googleButton.snp.makeConstraints { make in
            make.top.equalTo(appleButton.snp.bottom).offset(8)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(52)
            
        }
    }
    @objc func editingDidbegin(_ sender: TextFieldWithPadding) {
        errorLabel.text = ""
        sender.layer.borderColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1.00).cgColor
    }
    @objc func editingDidEnd(_ sender: TextFieldWithPadding) {
        sender.layer.borderColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1.00).cgColor
    }
    
    @objc func showPassword(_ sender: Any) {
        passwordTextField.isSecureTextEntry.toggle()
        if  !passwordTextField.isSecureTextEntry {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.hidePassword()
            }
        }
    }
    func hidePassword(){
        passwordTextField.isSecureTextEntry = true
    }
    func startApp() {
        let tabBar = TabBar()
        tabBar.modalPresentationStyle = .fullScreen
        self.present(tabBar, animated: true, completion: nil)
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    @objc func openSignUp() {
        let signUp = SignUp()
        navigationController?.show(signUp, sender: self)
    }
    @objc func signIn() {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        if email.isEmpty || password.isEmpty {
            return
        }
        
        if !isValidEmail(email) {
            errorLabel.text = "Қате формат"
            emailTextField.layer.borderColor = UIColor(named: "TextRed")?.cgColor
            return
        }
        if errorLabel.text == "Қате формат" {
            passwordLabel.snp.updateConstraints { make in
                make.top.equalTo(errorLabel.snp.bottom).offset(16)
            }
        }
        
        SVProgressHUD.show()
        
        let parametres = ["email": email, "password": password]
        
        AF.request(Urls.SIGN_IN_URL, method: .post, parameters: parametres, encoding: JSONEncoding.default).responseData { response in
             
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
                    UserDefaults.standard.setValue(token, forKey: "accessToken")
                    self.startApp()
                } else {
                    SVProgressHUD.showError(withStatus: "CONNECTION_ERROR")
                }
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
