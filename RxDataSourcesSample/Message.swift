//
//  Message.swift
//  RxDataSourcesSample
//
//  Created by Siarhei Dukhovich on 6/19/19.
//  Copyright © 2019 Siarhei Dukhovich. All rights reserved.
//

import UIKit
import Differentiator

enum Message {
  case text(String)
  case attributedText(NSAttributedString)
  case photo(UIImage)
  case location(lat: Double, lon: Double)
}

extension Message: IdentifiableType {
  var identity : String {
    switch self {
    case let .text(text):
      return "text_\(text)"
    case let .attributedText(text):
      return "attributed_\(text)"
    case let .location(lat: lat, lon: lon):
      return "\(lat)_\(lon)"
    case let .photo(image):
      guard let data = image.pngData() else { return "image" }
      return String(data.hashValue)
    }
  }
}

extension Message: Equatable {}
