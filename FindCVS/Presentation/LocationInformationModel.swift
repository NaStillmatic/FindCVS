//
//  LocationInformationModel.swift
//  FindCVS
//
//  Created by HwangByungJo  on 2022/07/15.
//

import Foundation
import RxSwift

struct LocationInformationModel {
  var localNetwork: LocalNetwork
  
  init(localNetwork: LocalNetwork = LocalNetwork()) {
    self.localNetwork = localNetwork
  }
  
  func getLocation(by mapPoint: MTMapPoint) -> Single<Result<LocationData, URLError>> {
    return localNetwork.getLocation(by: mapPoint)
  }
  
  func documentCellData(_ data: [KLDocument]) -> [DetailListCelldata] {
    return data.map {
      let address = $0.roadAddressName.isEmpty ? $0.addressName : $0.roadAddressName
      let point = documentToMTMapPoint($0)
      return DetailListCelldata(placeName: $0.placeName,
                                address: address,
                                distance: $0.distance,
                                point: point)
    }
  }
  
  func documentToMTMapPoint(_ doc: KLDocument) -> MTMapPoint {
    
    let longitude = Double(doc.x) ?? .zero
    let latitude = Double(doc.y) ?? .zero    
    return MTMapPoint(geoCoord: MTMapPointGeo(latitude: latitude, longitude: longitude))
  }
}
