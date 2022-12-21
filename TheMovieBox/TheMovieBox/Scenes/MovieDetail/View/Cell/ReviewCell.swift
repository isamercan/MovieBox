//
//  ReviewCell.swift
//  TheMovieBox
//
//  Created by isa Mercan on 21.12.2022.
//

import UIKit
import Kingfisher
class ReviewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var avatarPrefixNameLabel: UILabel!
    @IBOutlet weak var gravatarView: UIView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var reviewLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = StyleConstants.Size.medium
        containerView.backgroundColor = StyleConstants.Color.pastelBlue?.withAlphaComponent(0.2)
    }
    
    func setCellData(model: Review) {
        authorLabel.text = model.author
        gravatarView.backgroundColor = .random
        gravatarView.layer.cornerRadius = StyleConstants.Size.small
        avatarPrefixNameLabel.text = String(model.author?.prefix(2) ?? "")
        reviewLabel.text = model.content
    }
}
