//
//  ImageListCell.swift
//  ImageFeed
//
//  Created by DMITRY KHLOPTSOV on 18.11.2022.
//

import UIKit

final class ImageListCell: UITableViewCell {
    static let reuseIdentifier = "ImageListCell"

    @IBOutlet var cellImageView: UIImageView!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var dateView: UIView!
    @IBOutlet var dateLabel: UILabel!
}
