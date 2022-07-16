//
//  MTMapViewError.swift
//  FindCVS
//
//  Created by HwangByungJo  on 2022/07/14.
//

import Foundation

enum MTMapViewError: Error {
  case failedUpdatingCurrentLoaction
  case locationAuthorizationDenied
  
  var errorDescription: String {
    
    switch self {
    case .failedUpdatingCurrentLoaction:
      return "현재 위치를 불러오지 못했어요. 잠시 후 다시 시도해주세요."
    case .locationAuthorizationDenied:
      return "위치 정보를 빌활성화하면 사용자의 현재 위치를 알 수 없어요."
    }
  }
}

