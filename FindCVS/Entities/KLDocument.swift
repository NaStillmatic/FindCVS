//
//  KLDocument.swift
//  FindCVS
//
//  Created by HwangByungJo  on 2022/07/14.
//

import Foundation

struct KLDocument: Decodable {
  
  let addressName: String
  let categoryGroupCode: String
  let categoryGroupName: String
  let categoryName: String
  let distance: String
  let id: String
  let phone: String
  let placeName: String
  let placeURL: String
  let roadAddressName: String
  let x: String
  let y: String
  
  
  enum CodingKeys: String, CodingKey {
    
    case x, y, distance, id, phone
    case addressName = "address_name"
    case categoryGroupCode = "category_group_code"
    case categoryGroupName = "category_group_name"
    case categoryName = "category_name"
    case placeName = "place_name"
    case placeURL = "place_url"
    case roadAddressName = "road_address_name"
  }
}
  
