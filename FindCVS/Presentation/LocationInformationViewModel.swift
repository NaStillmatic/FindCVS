//
//  LocationInformationViewModel.swift
//  FindCVS
//
//  Created by HwangByungJo  on 2022/07/14.
//

import Foundation
import RxCocoa
import RxSwift

struct LocationInformationViewModel {
  
  let disposeBag = DisposeBag()
  
  // subViewModels
  let detailListBackgroundViewModel = DetailListBackgroundViewModel()
  
  // ViewModel -> View
  
  let setMapCenter: Signal<MTMapPoint>
  let errorMessage: Signal<String>
  let detailListCellData: Driver<[DetailListCelldata]>
  let scrollToSelectedLoaction: Signal<Int>
  
  
  // View -> ViewModel
  
  let currentLoaction = PublishRelay<MTMapPoint>()
  let mapCenterPoint = PublishRelay<MTMapPoint>()
  let selectPOIItem = PublishRelay<MTMapPOIItem>()
  let mapViewError = PublishRelay<String>()
  let currentLocationButtonTapped = PublishRelay<Void>()
  let detilListItemSelected = PublishRelay<Int>()
  
  private let documentData = PublishSubject<[KLDocument]>()
  
  init(model: LocationInformationModel = LocationInformationModel()) {
    
    // MARK: - 네트워크 통신으로 데이터 불러오기
    
    let cvsLocationDataResult = mapCenterPoint
      .flatMapLatest(model.getLocation)
      .share()
    
    let cvsLocationDataValue = cvsLocationDataResult
      .compactMap { data -> LocationData? in
        guard case let .success(value) = data else {
          return nil
        }
        return value
      }
      
    
    let cvsLocationDataErrorMessage = cvsLocationDataResult
      .compactMap { data -> String? in
        switch data {
        case let .success(data) where data.documents.isEmpty:
          return """
                500m 근처에 이용할 수 있는 편의점이 없어요.
                지도 위치를 옮겨서 재검색 해주세요.
                """
        case let .failure(error):
          return error.localizedDescription
        default:
          return nil
        }
      }
    
    cvsLocationDataValue
      .map { $0.documents }
      .bind(to: documentData)
      .disposed(by: disposeBag)
    
    // MARK: - 지도 중심점 설정
    let selectDetailListItem = detilListItemSelected
      .withLatestFrom(documentData) { $1[$0] }
      .map { data -> MTMapPoint in
        guard let longitude = Double(data.x),
              let latitude = Double(data.y) else {
          return MTMapPoint()
        }
        let geoCoord = MTMapPointGeo(latitude: latitude, longitude: longitude)
        return MTMapPoint(geoCoord:geoCoord)
      }
    
    let moveToCurrentLocation = currentLocationButtonTapped
      .withLatestFrom(currentLoaction)
    
    let currentMapCenter = Observable
      .merge(
        selectDetailListItem,
        currentLoaction.take(1),
        moveToCurrentLocation
      )
    
    setMapCenter = currentMapCenter
      .asSignal(onErrorSignalWith: .empty())
    
    errorMessage = Observable
      .merge(
        cvsLocationDataErrorMessage,
        mapViewError.asObservable()
      )
      .asSignal(onErrorJustReturn: "잠시 후 다시 시도해 주세요.")
    
    
    detailListCellData = documentData
      .map(model.documentCellData)
      .asDriver(onErrorDriveWith: .empty())
    
    documentData
      .map { !$0.isEmpty }
      .bind(to: detailListBackgroundViewModel.shouldHidStatusLabel)
      .disposed(by: disposeBag)
                
    scrollToSelectedLoaction = selectPOIItem
      .map { $0.tag }
      .asSignal(onErrorJustReturn: 0)
  }
}
