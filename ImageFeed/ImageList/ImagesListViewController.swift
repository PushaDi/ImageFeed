//
//  ViewController.swift
//  ImageFeed
//
//  Created by DMITRY KHLOPTSOV on 18.11.2022.
//

import UIKit

class ImagesListViewController: UIViewController {
    
    private var photosName = [String]()
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
    @IBOutlet private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photosName = Array(0..<20).map{ "\($0).png" }
    }
    
    
    
    
}


extension ImagesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageListCell.reuseIdentifier, for: indexPath)
        
        guard let imageListCell = cell as? ImageListCell else {
            return UITableViewCell()
        }
        
        configCell(for: imageListCell, with: indexPath)
        
        return cell
    }
        
    func configCell(for cell: ImageListCell, with indexPath: IndexPath) {
                
        let imageName = photosName[indexPath.row]
        
        guard let mockedImage = UIImage(named: imageName) else { return }
        cell.cellImageView.image = mockedImage
                
        let dateToday = dateFormatter.string(from: Date.init())
        cell.dateLabel.text = dateToday
        
        
        let likeActiveImage = UIImage(named: "LikeImageActive")
        let likeNoActiveImage = UIImage(named: "LikeImageNoActive")
        switch indexPath.row % 2 {
        case 0:
            cell.likeButton.setImage(likeActiveImage, for: .normal)
        default:
            cell.likeButton.setImage(likeNoActiveImage, for: .normal)
        }
    }
}

extension ImagesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { }
}

