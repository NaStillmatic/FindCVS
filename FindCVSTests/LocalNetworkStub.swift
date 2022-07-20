//
//  LocalNetworkStub.swift
//  FindCVSTests
//
//  Created by HwangByungJo  on 2022/07/19.
//

import Foundation
import RxSwift
import Stubber

@testable import FindCVS

class LocalNetworkStub: LocalNetwork {
  
  override func getLocation(by mapPoint: MTMapPoint) -> Single<Result<LocationData, URLError>> {
    return Stubber.invoke(getLocation, args: mapPoint)
  }
}
