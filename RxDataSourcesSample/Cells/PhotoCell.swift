//
//  PhotoCell.swift
//  RxDataSourcesSample
//
//  Created by Siarhei Dukhovich on 6/19/19.
//  Copyright © 2019 Siarhei Dukhovich. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {

  @IBOutlet private var photoImageView: UIImageView!

  var photo: UIImage? {
    didSet {
      photoImageView.image = photo
    }
  }
}
