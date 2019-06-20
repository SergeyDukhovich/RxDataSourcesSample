//
//  Message.swift
//  RxDataSourcesSample
//
//  Created by Siarhei Dukhovich on 6/19/19.
//  Copyright © 2019 Siarhei Dukhovich. All rights reserved.
//

import UIKit

enum Message {
  case text(String)
  case attributedText(NSAttributedString)
  case photo(UIImage)
  case location(lat: Double, lon: Double)
}
