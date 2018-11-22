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
    
    lazy var downloadsInProgress: [IndexPath: Operation] = [:]
    
    var tileProvider: TileProviding = { return TileProvider() }()
    
    var tiles: [Tile] = {
        let numberOfTiles = 30
        return (0..<numberOfTiles)
            .map { _ in
                let ne = CLLocationCoordinate2D(latitude: CLLocationDegrees(arc4random()), longitude: CLLocationDegrees(arc4random()))
                let sw = CLLocationCoordinate2D(latitude: CLLocationDegrees(arc4random()), longitude: CLLocationDegrees(arc4random()))
                return Tile(neCoordinate: ne, swCoordinate: sw)
            }
        }()
    
    var tileRequests: [IndexPath: TileRequest] = [:]
    
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
        return tiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        //1
        if cell.accessoryView == nil {
            let indicator = UIActivityIndicatorView(style: .gray)
            cell.accessoryView = indicator
        }
        let indicator = cell.accessoryView as! UIActivityIndicatorView
        
        let tile = tiles[indexPath.item]
        let tileRequest = tileRequests[indexPath, default: TileRequest(tile: tile)]
        
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
            startDownload(for: tileRequest, at: indexPath)
        case .processing:
            break
        }
        
        return cell
    }
    
    func startDownload(for tile: TileRequest, at indexPath: IndexPath) {
//        //1
//        guard downloadsInProgress[indexPath] == nil else {
//            return
//        }
        
        //2
        let operation = TileQueuerDownloadOperation(tile)
        
        //3
        operation.completionBlock = { [unowned self] in
            if operation.isCancelled {
                return
            }
            
            DispatchQueue.main.async {
//                self.downloadsInProgress.removeValue(forKey: indexPath)
                self.tileTableView.reloadRows(at: [indexPath], with: .fade)
            }
        }
        
        //4
//        self.downloadsInProgress[indexPath] = operation
    }
}
