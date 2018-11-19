//
//  ViewController.swift
//  DownloadManager
//
//  Created by ivan_man-kit-cheung on 11/17/18.
//  Copyright © 2018 ivan_man-kit-cheung. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

  @IBOutlet private weak var tileTableView: UITableView!
  let pendingOperations = PendingOperations()

  var tileRequests: [TileRequest] = {
    let numberOfTiles = 30
    return (0..<numberOfTiles)
      .map { _ in
        let ne = CLLocationCoordinate2D(latitude: CLLocationDegrees(arc4random()), longitude: CLLocationDegrees(arc4random()))
        let sw = CLLocationCoordinate2D(latitude: CLLocationDegrees(arc4random()), longitude: CLLocationDegrees(arc4random()))
        let tile = Tile(neCoordinate: ne, swCoordinate: sw)
        return TileRequest(tile: tile)
      }
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    setupTableView()
  }

  private func setupTableView() {
    tileTableView.reloadData()
    tileTableView.delegate = self
    tileTableView.dataSource = self
  }
}

extension ViewController: UITableViewDelegate {

}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tileRequests.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

    //1
    if cell.accessoryView == nil {
      let indicator = UIActivityIndicatorView(style: .gray)
      cell.accessoryView = indicator
    }
    let indicator = cell.accessoryView as! UIActivityIndicatorView

    let tileRequest = tileRequests[indexPath.item]

    switch (tileRequest.status) {
    case .success(let result):
      indicator.stopAnimating()
      cell.textLabel?.text = result
    case .cancelled:
      indicator.stopAnimating()
    case .failure(let error):
      indicator.stopAnimating()
      cell.textLabel?.text = "Failed to load: \(error.localizedDescription)"
    case .notStarted:
      indicator.startAnimating()
      startOperations(for: tileRequest, at: indexPath)
    case .processing:
      break
    }

    return cell
  }

  func startOperations(for tile: TileRequest, at indexPath: IndexPath) {
    switch (tile.status) {
    case .notStarted:
      startDownload(for: tile, at: indexPath)
    default:
      NSLog("do nothing")
    }
  }

  func startDownload(for tile: TileRequest, at indexPath: IndexPath) {
    //1
    guard pendingOperations.downloadsInProgress[indexPath] == nil else {
      return
    }

    //2
    let downloader = TileDownloadOperation(tile)

    //3
    downloader.completionBlock = {
      if downloader.isCancelled {
        return
      }

      DispatchQueue.main.async {
        self.pendingOperations.downloadsInProgress.removeValue(forKey: indexPath)
        self.tileTableView.reloadRows(at: [indexPath], with: .fade)
      }
    }

    //4
    pendingOperations.downloadsInProgress[indexPath] = downloader

    //5
    pendingOperations.downloadQueue.addOperation(downloader)
  }
}
