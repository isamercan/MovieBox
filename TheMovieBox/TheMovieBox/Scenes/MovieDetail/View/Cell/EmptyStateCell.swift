//
//  EmptyStateCell.swift
//  TheMovieBox
//
//  Created by isa Mercan on 5.01.2023.
//

import UIKit

class EmptyStateCell: UITableViewCell {

    @IBOutlet weak var discoverButton: UIButton!
    weak var delegate: EmptyStateCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        discoverButton.backgroundColor = StyleConstants.Color.darkYellow
        discoverButton.layer.cornerRadius = StyleConstants.Size.xSmall
        discoverButton.tintColor = StyleConstants.Color.darkBlue
    }
    
    func setCellData(delegate: EmptyStateCellDelegate) {
        self.delegate = delegate
    }
    
    @IBAction func actionDiscover(_ sender: UIButton) {
        delegate?.didTappedRefresh()
    }
}
