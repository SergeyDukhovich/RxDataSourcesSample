//
//  Message.swift
//  RxDataSourcesSample
//
//  Created by Siarhei Dukhovich on 6/19/19.
//  Copyright © 2019 Siarhei Dukhovich. All rights reserved.
//

import UIKit
import Differentiator

class MessageObject: NSObject {
  let message: Message
  let messageId: String

  init(message: Message, messageId: String) {
    self.message = message
    self.messageId = messageId
  }

  override func isEqual(_ object: Any?) -> Bool {
    guard let obj = object as? MessageObject else { return false }
    return messageId == obj.messageId
  }
}

enum Message {
  case text(String)
  case attributedText(NSAttributedString)
  case photo(UIImage)
  case location(lat: Double, lon: Double)
}

extension MessageObject: IdentifiableType {
  var identity : String {
    return messageId
  }
}
