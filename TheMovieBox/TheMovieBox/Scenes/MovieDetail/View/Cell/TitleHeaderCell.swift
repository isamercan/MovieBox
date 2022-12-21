//
//  TitleHeaderCell.swift
//  TheMovieBox
//
//  Created by isa Mercan on 21.12.2022.
//

import UIKit

class TitleHeaderCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCellData(text: String) {
        titleLabel.text = text
    }
}
