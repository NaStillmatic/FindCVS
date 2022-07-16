//
//  DetailListBackgroundViewModel.swift
//  FindCVS
//
//  Created by HwangByungJo  on 2022/07/14.
//

import Foundation
import RxCocoa
import RxSwift

struct DetailListBackgroundViewModel {
  
  // viewModel -> view
  let isStatusLabelHidden: Signal<Bool>
  
  // 외부에서 전달받은 값
  let shouldHidStatusLabel = PublishSubject<Bool>()
  
  init() {
    
    isStatusLabelHidden = shouldHidStatusLabel
      .asSignal(onErrorJustReturn: true)
  }
  
  
}
