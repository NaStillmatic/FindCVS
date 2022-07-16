//
//  LocalNetwork.swift
//  FindCVS
//
//  Created by HwangByungJo  on 2022/07/15.
//

import Foundation
import RxSwift

class LocalNetwork: URLSession {
  private let session: URLSession
  let api = LocalAPI()
  
  init(sesion: URLSession = .shared) {
    self.session = sesion
  }
  
  func getLocation(by mapPoint: MTMapPoint) -> Single<Result<LocationData, URLError>> {
    guard let url = api.getLocation(by: mapPoint).url else {
      return .just(.failure(URLError(.badURL)))
    }
    let request  = NSMutableURLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("KakaoAK 787cd405a3a785bfafa058ddad389825", forHTTPHeaderField: "Authorization")
    
    return session.rx.data(request: request as URLRequest)
      .map { data in
        do {
          let locationData = try JSONDecoder().decode(LocationData.self, from: data)
          return .success(locationData)
        } catch {
          return .failure(URLError(.cannotParseResponse))
        }
        
      }
      .catch { _ in .just(Result.failure(URLError(.cannotLoadFromNetwork)))}
      .asSingle()
  }
}
