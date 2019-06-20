//
//  ViewController.swift
//  RxDataSourcesSample
//
//  Created by Siarhei Dukhovich on 6/19/19.
//  Copyright © 2019 Siarhei Dukhovich. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

private enum CellIdentifier: String {
  case text
  case location
  case photo
}

private extension Message {
  var identifier: CellIdentifier {
    switch self {
    case .text(_), .attributedText(_):
      return .text
    case .location(lat: _, lon: _):
      return .location
    case .photo(_):
      return .photo
    }
  }
}

class ViewController: UIViewController {

  private var messages = Observable<[Message]>.just([
    .attributedText(NSAttributedString(string: "Blue text",
                                       attributes: [NSAttributedString.Key.foregroundColor : UIColor.blue])),
    .text("On the other hand, we denounce with righteous indignation and dislike men who are so beguiled and demoralized by the charms of pleasure of the moment"),
    .photo(UIImage(named: "rx-wide")!),
    .attributedText(NSAttributedString(string: "Red text",
                                       attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])),
    .text("Another Message"),
    .location(lat: 37.334722, lon: -122.008889),
    .text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"),
    .photo(UIImage(named: "rx-logo")!),
    .attributedText(NSAttributedString(string: "Green text",
                                       attributes: [NSAttributedString.Key.foregroundColor : UIColor.green])),
    .location(lat: 53.9, lon: 27.56667),
    .text("There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text."),
    .attributedText(NSAttributedString(string: "Yellow text",
                                       attributes: [NSAttributedString.Key.foregroundColor : UIColor.yellow])),
    ])

  private let disposeBag = DisposeBag()

  @IBOutlet private var tableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.register(UITableViewCell.self,
                       forCellReuseIdentifier: CellIdentifier.text.rawValue)
    tableView.register(UINib(nibName: "PhotoCell", bundle: nil),
                       forCellReuseIdentifier: CellIdentifier.photo.rawValue)
    tableView.register(UINib(nibName: "LocationCell", bundle: nil),
                       forCellReuseIdentifier: CellIdentifier.location.rawValue)

    tableView.allowsSelection = false

    messages
      .bind(to: tableView.rx.items) { (table: UITableView, index: Int, message: Message) in
        guard let cell = table.dequeueReusableCell(withIdentifier: message.identifier.rawValue) else { return UITableViewCell() }
        switch message {
        case let .text(message):
          return ViewController.configure(text: message, cell: cell)
        case let .attributedText(attributed):
          return ViewController.configure(attributed: attributed, cell: cell)
        case let .photo(photo):
          return ViewController.configure(photo: photo, cell: cell)
        case let .location(lat: lat, lon: lon):
          return ViewController.configure(lat: lat, lon: lon, cell: cell)
        }
      }
    .disposed(by: disposeBag)
  }

  static func configure(text: String, cell: UITableViewCell) -> UITableViewCell {
    cell.textLabel?.numberOfLines = 0
    cell.textLabel?.text = text
    return cell
  }

  static func configure(attributed: NSAttributedString,
                        cell: UITableViewCell) -> UITableViewCell {
    cell.textLabel?.numberOfLines = 0
    cell.textLabel?.attributedText = attributed
    return cell
  }

  static func configure(photo: UIImage,
                        cell: UITableViewCell) -> UITableViewCell {
    guard let photoCell = cell as? PhotoCell else { return cell }
    photoCell.photo = photo
    return cell
  }

  static func configure(lat: Double,
                        lon: Double,
                        cell: UITableViewCell) -> UITableViewCell {
    guard let locationCell = cell as? LocationCell else { return cell }
    locationCell.lat = lat
    locationCell.lon = lon
    return cell
  }
}
