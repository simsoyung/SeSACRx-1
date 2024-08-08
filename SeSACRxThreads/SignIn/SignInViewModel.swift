//
//  SignInViewModel.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import Foundation
import RxSwift
import RxCocoa

class SignInViewModel {
    struct Input {
        let email: ControlProperty<String?>
        let password: ControlProperty<String?>
        let loginButtom: ControlEvent<Void>
    }
    struct Output {
        let loginButtom: ControlEvent<Void>
        let emailText: BehaviorRelay<String>
        let passwordText: BehaviorRelay<String>
        let emailValue: Observable<Bool>
        let passwordValue: Observable<Bool>
    }
    
    func transform(input: Input) -> Output {
        let email = input.email
            .orEmpty
            .map{$0.count >= 8}
        
        let emailText = BehaviorRelay(value: "8자리 이상입력해주세요.")
            
        let password = input.password
            .orEmpty
            .map{$0.count >= 10}
        
        let passwordText = BehaviorRelay(value: "10자리 이상입력해주세요.")
        
        return Output(loginButtom: input.loginButtom, emailText: emailText, passwordText: passwordText, emailValue: email, passwordValue: password)
    
    }
    
}
