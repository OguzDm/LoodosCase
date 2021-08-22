//
//  SearchTableViewCell.swift
//  LoodosCase
//
//  Created by Oguz Demırhan on 22.08.2021.
//

import UIKit
import Kingfisher

final class SearchTableViewCell: UITableViewCell {

    static let reuseIdentifier = "SearchTableViewCell"
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        movieImageView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(image: String, name: String, type: String) {
        guard let imageURL = URL(string: image) else {return}
        movieImageView.kf.indicatorType = .activity
        movieImageView.kf.setImage(with: imageURL)
        movieNameLabel.text = name
        typeLabel.text = type.capitalized
    }
}
