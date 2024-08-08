//
//  BirthdayViewModel.swift
//  SeSACRxThreads
//
//  Created by 심소영 on 8/8/24.
//

import Foundation
import RxSwift
import RxCocoa


class BirthdayViewModel {
    let disposeBag = DisposeBag()
    
    struct Input {
        let birthdayPicker: ControlProperty<Date>
        let nextButtonTap: ControlEvent<Void> //다음버튼 클릭
    }
    struct Output {
        let year: BehaviorRelay<Int>
        let month: BehaviorRelay<Int>
        let day: BehaviorRelay<Int>
        let nextButtonTap: ControlEvent<Void> // 다음버튼을 클릭시 다른 페이지로 이동
    }
    
    func transform(input: Input) -> Output {
        let year = BehaviorRelay(value: 2024)
        let month = BehaviorRelay(value: 8)
        let day = BehaviorRelay(value: 7)
        
        input.birthdayPicker
            .bind(with: self) { owner, value in
                let component = Calendar.current.dateComponents([.year,.month, .day], from: value)
                //지금 받아온 날짜값을 배열로 내보내준다
                //onNext == accept
                year.accept(component.year!)
                month.accept(component.month!)
                day.accept(component.day!)
            }
            .disposed(by: disposeBag)
        
        return Output(year: year, month: month, day: day, nextButtonTap: input.nextButtonTap)
    }
    
    
}
