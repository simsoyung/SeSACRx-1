//
//  SignInViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SignInViewController: UIViewController {

    let emailTextField = SignTextField(placeholderText: "이메일을 입력해주세요")
    let passwordTextField = SignTextField(placeholderText: "비밀번호를 입력해주세요")
    let signInButton = PointButton(title: "로그인")
    let signUpButton = UIButton()
    let emailLabel = UILabel()
    let passwordLabel = UILabel()
    let viewModel = SignInViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.white
        configureLayout()
        configure()
        bind()
    }
    
    @objc func signUpButtonClicked() {
        navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
    func bind(){
        
        let input = SignInViewModel.Input(email: emailTextField.rx.text, password: passwordTextField.rx.text, loginButtom: signInButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.emailText
            .bind(with: self) { owner, value in
                owner.emailLabel.text = value
            }
            .disposed(by: disposeBag)
        
        output.emailValue
            .bind(to: emailLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        output.passwordText
            .bind(to: passwordLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.passwordValue
            .bind(to: signInButton.rx.isEnabled,
                  passwordLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        output.passwordValue
            .bind(with: self) { owner, value in
                let color: UIColor = value ? .black : .lightGray
                owner.signInButton.backgroundColor = color
            }
            .disposed(by: disposeBag)
        output.loginButtom
            .bind(with: self) { owner, _ in
                owner.navigationController?.pushViewController(SignUpViewController(), animated: true)
            }
        
        
    }
    
    func configure() {
        signUpButton.setTitle("회원이 아니십니까?", for: .normal)
        signUpButton.setTitleColor(Color.black, for: .normal)
    }
    
    func configureLayout() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        view.addSubview(signUpButton)
        view.addSubview(emailLabel)
        view.addSubview(passwordLabel)
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(20)
        }
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(emailLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(20)
        }
        
        signInButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(signInButton.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    

}
