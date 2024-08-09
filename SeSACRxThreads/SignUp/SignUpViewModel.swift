//
//  SignUpViewModel.swift
//  SeSACRxThreads
//
//  Created by 심소영 on 8/8/24.
//

import Foundation
import RxSwift
import RxCocoa

final class SignUpViewModel {
    struct Input {
        let email: ControlProperty<String?>
        let nextTap: ControlEvent<Void>
    }
    struct Output {
        let emailLabel: BehaviorRelay<String>
        let emailCheck: Observable<Bool>
        let nextTap: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        let emailText = BehaviorRelay(value: "사용 가능한 이메일을 입력해주세요.")
        
        let email = input.email
            .orEmpty
            .map{$0.count >= 8}
        
        return Output(emailLabel: emailText, emailCheck: email, nextTap: input.nextTap)
    }
}
