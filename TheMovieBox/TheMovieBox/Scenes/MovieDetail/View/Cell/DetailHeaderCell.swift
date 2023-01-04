//
//  DetailHeaderCell.swift
//  TheMovieBox
//
//  Created by isa Mercan on 21.12.2022.
//

import UIKit

class DetailHeaderCell: UITableViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTypeLabel: UILabel!
    @IBOutlet weak var shortInfoLabel: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var goBackButton: UIButton!
    @IBOutlet weak var addFavoriteButton: UIButton!
    var model: MovieModel?
    var isInFavoriteList: Bool = false
    weak var delegate: DetailHeaderCellDelegate?
    
    @IBOutlet weak var typeView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        goBackButton.setTitle("", for: .normal)
        let backImage = UIImage(named: "back-arrow")?.withRenderingMode(.alwaysTemplate)
        goBackButton.setImage(backImage, for: .normal)
        goBackButton.tintColor = UIColor.white
        
        addFavoriteButton.setTitle("", for: .normal)
        let likeImage = UIImage(named: "like")?.withRenderingMode(.alwaysTemplate)
        addFavoriteButton.setImage(likeImage, for: .normal)        
        posterImageView.layer.cornerRadius = StyleConstants.Size.large
        typeView.layer.cornerRadius = StyleConstants.Size.xSmall
        typeView.backgroundColor = StyleConstants.Color.darkYellow
    }
    
    func setCellData(model: MovieModel, delegate: DetailHeaderCellDelegate) {
        self.delegate = delegate
        self.model = model
        isInFavoriteList = UserDefaultsManager.shared.isInList(model: model, forKey: .FavoriteMovies)
        addFavoriteButton.tintColor = isInFavoriteList ? UIColor.white : UIColor.white.withAlphaComponent(0.5)
        let url = URL(string: NetworkConstants.posterBaseUrl + (model.posterPath ?? ""))
        posterImageView.kf.setImage(with: url)
        title.text = model.title
        movieTypeLabel.text = "\u{1F3AC}" + " " + (model.genres?[0].name ?? "")
        shortInfoLabel.text = "\u{1F525}" + " " + String(model.voteAverage ?? 0) + "    " +  "\u{1F551}" + " " + String(model.releaseDate ?? "") + "    " +  "\u{1F551}" + " " + "Duration: 2h 4m"
        descriptionLabel.text = model.overview
    }
    
    @IBAction func btnAction(_ sender: UIButton) {
        if sender.tag == 0 {
            delegate?.didTappedBack()
        } else if sender.tag == 1 {
            guard let model = model else { return }
            guard !isInFavoriteList else {
                UserDefaultsManager.shared.removeMovie(model: model, forKey: .FavoriteMovies)
                addFavoriteButton.tintColor = UIColor.white.withAlphaComponent(0.5)
                isInFavoriteList = false
                return
            }
            UserDefaultsManager.shared.addMovie(model: model, forKey: .FavoriteMovies)
            isInFavoriteList = true
            addFavoriteButton.tintColor = UIColor.white
        } else if sender.tag == 2 {
            delegate?.didTappedHome()
        }
    }
}
