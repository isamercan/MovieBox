//
//  DashboardMoviesColCell.swift
//  TheMovieBox
//
//  Created by isa Mercan on 21.12.2022.
//

import UIKit
import Kingfisher

class DashboardMoviesColCell: UICollectionViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    var model: MovieModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    
    func setupUI() {
        posterImageView.layer.cornerRadius = StyleConstants.Size.medium
    }
    func setCellData(model: MovieModel) {
        self.model = model
        let url = URL(string: NetworkConstants.posterBaseUrl + (model.posterPath ?? ""))
        posterImageView.kf.setImage(with: url)
        titleLabel.text = model.title
        dateLabel.text = model.releaseDate
    }
}
