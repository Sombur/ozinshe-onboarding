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
import Localize_Swift

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    lazy var scrollView = {
        let sv = UIScrollView()
        
        return sv
    }()
    
    lazy var contentView = {
        let view = UIView()
        
        return view
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.text = "Сәлем"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "111827-FFFFFF")
        
        return label
    }()
    
    let subTitleLabel = {
        let label = UILabel()
        label.text = "Аккаунтқа кіріңіз"
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
        tf.placeholder = "Сіздің email"
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
    
    let errorLabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "SFProDisplay-Medium", size: 14)
        label.textColor = UIColor(named: "FF402B")
        
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
        label.textColor = UIColor(named: "111827-FFFFFF")
        
        return label
    }()
    
    let passwordTextField = {
        let tf = TextFieldWithPadding()
        tf.placeholder = "Сіздің құпия сөзіңіз"
        tf.textColor = UIColor(named: "111827-FFFFFF")
        tf.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        tf.layer.cornerRadius = 12
        tf.layer.borderWidth = 1.0
        tf.layer.borderColor = UIColor(named: "E5EBF0-9CA3AF")?.cgColor
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
    
    let passwordForgotButton = {
        let label = UILabel()
        label.text = "Құпия сөзді ұмыттыңыз ба?"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        label.textColor = UIColor(named: "B376F7")
        label.textAlignment = .right
        
        return label
    }()
    
    let startButton = {
        let button = UIButton()
        button.setTitle("Кіру", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor(named: "7E2DFC")
        button.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        
        return button
    }()
    
    let accountLabel = {
        let label = UILabel()
        label.text = "Аккаунтыныз жоқ па?"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        label.textColor = UIColor(named: "6B7280-FFFFFF")
        label.textAlignment = .right
        
        return label
    }()
    
    let signUpButton = {
        let button = UIButton()
        button.setTitle("Тіркелу", for: .normal)
        button.setTitleColor(UIColor(named: "9753FO"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        button.addTarget(self, action: #selector(openSignUp), for: .touchUpInside)
        
        return button
    }()
    
    let orLabel = {
        let label = UILabel()
        label.text = "Немесе"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(named: "9CA3AF")
        label.textAlignment = .center
        
        return label
    }()
    
    let appleButton = {
        let button = UIButton(type: .system)
        
        button.setImage(UIImage(named: "Apple"), for: .normal)
        button.setTitle("Apple ID-мен тіркеліңіз", for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        button.setTitleColor(UIColor(named: "111827-FFFFFF"), for: .normal)
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(named: "E5E7EB-FFFFFF")?.cgColor
        button.layer.backgroundColor = UIColor(named: "FFFFFF-4B5563")?.cgColor
        
        return  button
    }()
    
    let googleButton = {
        let button = UIButton(type: .system)
        
        button.setImage(UIImage(named: "Google"), for: .normal)
        button.setTitle("Google-мен тіркеліңіз", for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        button.setTitleColor(UIColor(named: "111827-FFFFFF"), for: .normal)
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(named: "E5E7EB-FFFFFF")?.cgColor
        button.layer.backgroundColor = UIColor(named: "FFFFFF-4B5563")?.cgColor
        
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
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(emailLabel)
        contentView.addSubview(emailTextField)
        contentView.addSubview(errorLabel)
        contentView.addSubview(emailImage)
        contentView.addSubview(passwordLabel)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(passwordImage)
        contentView.addSubview(showButton)
        contentView.addSubview(passwordForgotButton)
        contentView.addSubview(startButton)
        contentView.addSubview(accountLabel)
        contentView.addSubview(signUpButton)
        contentView.addSubview(orLabel)
        contentView.addSubview(appleButton)
        contentView.addSubview(googleButton)
        
        scrollView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints { make in
            //make.top.equalTo(view.safeAreaLayoutGuide)
            make.edges.horizontalEdges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
            make.height.equalTo(scrollView.frameLayoutGuide).priority(.medium)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(16)
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
        passwordForgotButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(17)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
        }
        startButton.snp.makeConstraints { make in
            make.top.equalTo(passwordForgotButton.snp.bottom).offset(40)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        accountLabel.snp.makeConstraints { make in
            make.top.equalTo(startButton.snp.bottom).offset(24)
            make.left.equalToSuperview().inset(90)
        }
        signUpButton.snp.makeConstraints { make in
            make.centerY.equalTo(accountLabel)
            make.left.equalTo(accountLabel.snp.right).offset(4)
        }
        orLabel.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(40)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
        }
        appleButton.snp.makeConstraints { make in
            make.top.equalTo(orLabel.snp.bottom).offset(16)
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
    //MARK: - localizeLanguage
    func localizeLanguage() {
        titleLabel.text = "HELLO".localized()
        subTitleLabel.text = "SIGN_IN".localized()
        emailTextField.placeholder = "YOUR_EMAIL".localized()
        passwordLabel.text = "PASSWORD".localized()
        passwordTextField.placeholder = "YOUR_PASSWORD".localized()
        passwordForgotButton.text = "FORGOT_YOUR_PASSWORD".localized()
        startButton.setTitle("LOGIN".localized(), for: .normal)
        accountLabel.text = "NO_ACCOUNT".localized()
        signUpButton.setTitle("SIGN_UP".localized(), for: .normal)
        orLabel.text = "OR".localized()
        appleButton.setTitle("SIGNUP_APPLE".localized(), for: .normal)
        googleButton.setTitle("SIGNUP_GOOGLE".localized(), for: .normal)
    }
    
    @objc func editingDidbegin(_ sender: TextFieldWithPadding) {
        errorLabel.text = ""
        sender.layer.borderColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1.00).cgColor
    }
    
    @objc func editingDidEnd(_ sender: TextFieldWithPadding) {
        sender.layer.borderColor = UIColor(red: 229/255, green: 245/255, blue: 240/255, alpha: 1.00).cgColor
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
        let tabBar = TabBarViewController()
        tabBar.modalPresentationStyle = .fullScreen
        self.present(tabBar, animated: true, completion: nil)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    @objc func openSignUp() {
        let signUp = SignUpViewController()
        navigationController?.show(signUp, sender: self)
        navigationItem.title = ""
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func signIn() {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        if email.isEmpty || password.isEmpty {
            return
        }
        
        if !isValidEmail(email) {
            errorLabel.text = "WRONG_FORMAT".localized()
            emailTextField.layer.borderColor = UIColor(named: "FF402B")?.cgColor
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
                    SVProgressHUD.showError(withStatus: "CONNECTION_ERROR".localized())
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
