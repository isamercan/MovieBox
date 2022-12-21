//
//  DashboardMoviesRowCell.swift
//  TheMovieBox
//
//  Created by isa Mercan on 21.12.2022.
//

import UIKit

class DashboardMoviesRowCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }
        
    weak var delegate: DashboardMoviesRowCellDelegate?
    var moviesRowCellVM: DashboardMoviesRowCellViewModel?
    static let heightCell: CGFloat = 340
    static let widthCell: CGFloat = 171
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    func initUI() {
        selectionStyle = .none
        collectionView.register(DashboardMoviesColCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
        
    func setCellData(title: String, model: [MovieModel], delegate: DashboardMoviesRowCellDelegate, titleColor: UIColor = .white) {
        moviesRowCellVM = DashboardMoviesRowCellViewModel(movies: model)
        titleLabel.text = title
        titleLabel.textColor = titleColor
        self.delegate = delegate
        collectionView.reloadData()
    }
}

extension DashboardMoviesRowCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesRowCellVM?.movies.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DashboardMoviesColCell = collectionView.dequeue(cellForRowAt: indexPath)
        guard let list = moviesRowCellVM?.movies, !list.isEmpty else { return cell }
        let item = list[indexPath.item]
        cell.setCellData(model: item)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: DashboardMoviesRowCell.widthCell, height: DashboardMoviesRowCell.heightCell)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return StyleConstants.Size.large
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return StyleConstants.Size.medium
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let list = moviesRowCellVM?.movies, !list.isEmpty else { return }
        let item = list[indexPath.item]
        delegate?.didTappedMovieItem(model: item)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
}
